-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nivell1-optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nivell1-optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nivell1-optica` DEFAULT CHARACTER SET utf8 ;
USE `nivell1-optica` ;

-- -----------------------------------------------------
-- Table `nivell1-optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nivell1-optica`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_first` VARCHAR(45) NOT NULL,
  `clients_last` VARCHAR(45) NOT NULL,
  `client_postcode` VARCHAR(45) NOT NULL,
  `client_telephone` INT NOT NULL,
  `client_email` VARCHAR(45) NOT NULL,
  `client_registerDate` DATETIME NOT NULL,
  `client_recommendation` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nivell1-optica`.`providers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nivell1-optica`.`providers` (
  `provider_id` INT NOT NULL,
  `provider_name` VARCHAR(45) NOT NULL,
  `provider_telephone` INT NOT NULL,
  `provider_fax` INT NOT NULL,
  `provider_NIF` INT NOT NULL,
  `provider_street` VARCHAR(45) NOT NULL,
  `provider_streetNumber` INT NOT NULL,
  `provider_floor` VARCHAR(45) NOT NULL,
  `provider_door` VARCHAR(45) NOT NULL,
  `provider_town` VARCHAR(45) NOT NULL,
  `provider_postcode` VARCHAR(45) NOT NULL,
  `provider_country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provider_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nivell1-optica`.`glass_brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nivell1-optica`.`glass_brand` (
  `glass_brand_id` INT NOT NULL AUTO_INCREMENT,
  `glass_brand_name` VARCHAR(45) NOT NULL,
  `providers_provider_id` INT NOT NULL,
  PRIMARY KEY (`glass_brand_id`, `providers_provider_id`),
  INDEX `fk_glass_brand_providers1_idx` (`providers_provider_id` ASC) VISIBLE,
  CONSTRAINT `fk_glass_brand_providers1`
    FOREIGN KEY (`providers_provider_id`)
    REFERENCES `nivell1-optica`.`providers` (`provider_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nivell1-optica`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nivell1-optica`.`glasses` (
  `glasses_id` INT NOT NULL AUTO_INCREMENT,
  `glasses_brand` VARCHAR(45) NOT NULL,
  `glasses_graduation` INT NOT NULL,
  `glasses_frame` VARCHAR(45) NOT NULL,
  `glasses_frameColor` VARCHAR(45) NOT NULL,
  `glasses_glassColor` VARCHAR(45) NOT NULL,
  `glasses_price` INT NOT NULL,
  `glasses_col` VARCHAR(45) NOT NULL,
  `glass_brand_glass_brand_id` INT NOT NULL,
  PRIMARY KEY (`glasses_id`, `glass_brand_glass_brand_id`),
  INDEX `fk_glasses_glass_brand1_idx` (`glass_brand_glass_brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_glass_brand1`
    FOREIGN KEY (`glass_brand_glass_brand_id`)
    REFERENCES `nivell1-optica`.`glass_brand` (`glass_brand_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nivell1-optica`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nivell1-optica`.`worker` (
  `worker_id` INT UNSIGNED NOT NULL,
  `worker_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`worker_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nivell1-optica`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nivell1-optica`.`orders` (
  `orders_id` INT NOT NULL AUTO_INCREMENT,
  `worker_worker_id` INT UNSIGNED NOT NULL,
  `glasses_glasses_id` INT NOT NULL,
  `clients_client_id` INT NOT NULL,
  PRIMARY KEY (`orders_id`, `worker_worker_id`, `glasses_glasses_id`, `clients_client_id`),
  INDEX `fk_orders_worker_idx` (`worker_worker_id` ASC) VISIBLE,
  INDEX `fk_orders_glasses1_idx` (`glasses_glasses_id` ASC) VISIBLE,
  INDEX `fk_orders_clients1_idx` (`clients_client_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`clients_client_id`)
    REFERENCES `nivell1-optica`.`clients` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_glasses1`
    FOREIGN KEY (`glasses_glasses_id`)
    REFERENCES `nivell1-optica`.`glasses` (`glasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_worker`
    FOREIGN KEY (`worker_worker_id`)
    REFERENCES `nivell1-optica`.`worker` (`worker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
