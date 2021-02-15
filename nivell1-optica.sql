-- MySQL Workbench Synchronization
-- Generated: 2021-02-15 19:47
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: genis

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `nivell1-optica` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `nivell1-optica`.`clients` (
  `client_id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_first` VARCHAR(45) NOT NULL,
  `clients_last` VARCHAR(45) NOT NULL,
  `client_postcode` VARCHAR(45) NOT NULL,
  `client_telephone` INT(11) NOT NULL,
  `client_email` VARCHAR(45) NOT NULL,
  `client_registerDate` DATETIME NOT NULL,
  `client_recommendation` VARCHAR(45) NULL DEFAULT NULL,
  `companies_have_workers_workers_id` INT(11) NOT NULL COMMENT 'id of the worker that sold the glass',
  PRIMARY KEY (`client_id`, `companies_have_workers_workers_id`),
  INDEX `fk_clients_companies_have_workers1_idx` (`companies_have_workers_workers_id` ASC) VISIBLE,
  CONSTRAINT `fk_clients_companies_have_workers1`
    FOREIGN KEY (`companies_have_workers_workers_id`)
    REFERENCES `nivell1-optica`.`companies_have_workers` (`workers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-optica`.`glasses` (
  `glasses_id` INT(11) NOT NULL AUTO_INCREMENT,
  `glasses_brand` VARCHAR(45) NOT NULL,
  `glasses_graduation` INT(11) NOT NULL,
  `glasses_frame` VARCHAR(45) NOT NULL,
  `glasses_frameColor` VARCHAR(45) NOT NULL,
  `glasses_glassColor` VARCHAR(45) NOT NULL,
  `glasses_price` INT(11) NOT NULL,
  `glasses_col` VARCHAR(45) NOT NULL,
  `providers_provider_id` INT(11) NOT NULL COMMENT 'glass provider id ',
  `companies_have_workers_workers_id` INT(11) NOT NULL COMMENT 'id of the worker that sold the glass',
  PRIMARY KEY (`glasses_id`, `providers_provider_id`, `companies_have_workers_workers_id`),
  INDEX `fk_glasses_providers1_idx` (`providers_provider_id` ASC) VISIBLE,
  INDEX `fk_glasses_companies_have_workers1_idx` (`companies_have_workers_workers_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_providers1`
    FOREIGN KEY (`providers_provider_id`)
    REFERENCES `nivell1-optica`.`providers` (`provider_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_glasses_companies_have_workers1`
    FOREIGN KEY (`companies_have_workers_workers_id`)
    REFERENCES `nivell1-optica`.`companies_have_workers` (`workers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-optica`.`providers` (
  `provider_id` INT(11) NOT NULL,
  `provider_name` VARCHAR(45) NOT NULL,
  `provider_telephone` INT(11) NOT NULL,
  `provider_fax` INT(11) NOT NULL,
  `provider_NIF` INT(11) NOT NULL,
  `providers_have_adresses_adress_id` INT(11) NOT NULL COMMENT 'adress of the provider\n',
  PRIMARY KEY (`provider_id`, `providers_have_adresses_adress_id`),
  INDEX `fk_providers_providers_have_adresses_idx` (`providers_have_adresses_adress_id` ASC) VISIBLE,
  CONSTRAINT `fk_providers_providers_have_adresses`
    FOREIGN KEY (`providers_have_adresses_adress_id`)
    REFERENCES `nivell1-optica`.`providers_have_adresses` (`adress_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-optica`.`providers_have_adresses` (
  `adress_id` INT(11) NOT NULL AUTO_INCREMENT,
  `adress_street` VARCHAR(45) NOT NULL,
  `adress_number` INT(11) NOT NULL,
  `adress_floor` VARCHAR(45) NOT NULL,
  `adress_door` VARCHAR(45) NOT NULL,
  `adress_city` VARCHAR(45) NOT NULL,
  `adress_postcode` VARCHAR(45) NOT NULL,
  `adress_country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adress_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-optica`.`companies_have_workers` (
  `workers_id` INT(11) NOT NULL AUTO_INCREMENT,
  `worker_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`workers_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
