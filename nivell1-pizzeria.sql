-- MySQL Workbench Synchronization
-- Generated: 2021-02-15 22:31
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: genis

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `nivell1-pizzeria`.`clients` 
ADD INDEX `fk_clients_towns1_idx` (`towns_town_id` ASC, `towns_provinces_province_id` ASC) VISIBLE,
DROP INDEX `fk_clients_towns1_idx` ;
;

CREATE TABLE IF NOT EXISTS `nivell1-pizzeria`.`orders` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_shipment` VARCHAR(3) NOT NULL COMMENT 'yes -  if shipment is needed\nno - if there is no shipment',
  `order_totalPrice` INT(11) NOT NULL,
  `order_pizzaCount` INT(11) NULL DEFAULT NULL,
  `order_hamburguerCount` INT(11) NULL DEFAULT NULL,
  `order_drinkCount` INT(11) NULL DEFAULT NULL,
  `order_deliverTime` DATE NULL DEFAULT NULL,
  `workers_worker_id` INT(11) NULL DEFAULT NULL,
  `shops_shop_id` INT(11) ZEROFILL NOT NULL,
  `clients_client_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`, `shops_shop_id`, `clients_client_id`),
  INDEX `fk_orders_shops1_idx` (`shops_shop_id` ASC) VISIBLE,
  INDEX `fk_orders_workers1_idx` (`workers_worker_id` ASC) VISIBLE,
  INDEX `fk_orders_clients1_idx` (`clients_client_id` ASC) VISIBLE,
  UNIQUE INDEX `workers_worker_id_UNIQUE` (`workers_worker_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_shops1`
    FOREIGN KEY (`shops_shop_id`)
    REFERENCES `nivell1-pizzeria`.`shops` (`shop_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_workers1`
    FOREIGN KEY (`workers_worker_id`)
    REFERENCES `nivell1-pizzeria`.`workers` (`worker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`clients_client_id`)
    REFERENCES `nivell1-pizzeria`.`clients` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-pizzeria`.`shops` (
  `shop_id` INT(11) ZEROFILL NOT NULL,
  `shop_adress` VARCHAR(45) NOT NULL,
  `shop_postcode` VARCHAR(45) NOT NULL,
  `towns_town_id` INT(11) NOT NULL,
  `towns_provinces_province_id` INT(11) NOT NULL,
  PRIMARY KEY (`shop_id`, `towns_town_id`, `towns_provinces_province_id`),
  INDEX `fk_shops_towns1_idx` (`towns_town_id` ASC, `towns_provinces_province_id` ASC) VISIBLE,
  CONSTRAINT `fk_shops_towns1`
    FOREIGN KEY (`towns_town_id` , `towns_provinces_province_id`)
    REFERENCES `nivell1-pizzeria`.`towns` (`town_id` , `provinces_province_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-pizzeria`.`provinces` (
  `province_id` INT(11) NOT NULL AUTO_INCREMENT,
  `province_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`province_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-pizzeria`.`workers` (
  `worker_id` INT(11) NOT NULL,
  `worker_name` VARCHAR(45) NOT NULL,
  `worker_surname` VARCHAR(45) NOT NULL,
  `workers_nif` VARCHAR(15) NOT NULL,
  `worker_telephone` INT(11) NOT NULL,
  `worker_role` VARCHAR(45) NOT NULL COMMENT 'if the worker is a cooker or a deliverer. ',
  `shops_shop_id` INT(11) ZEROFILL NOT NULL,
  PRIMARY KEY (`worker_id`, `shops_shop_id`),
  INDEX `fk_workers_shops1_idx` (`shops_shop_id` ASC) VISIBLE,
  CONSTRAINT `fk_workers_shops1`
    FOREIGN KEY (`shops_shop_id`)
    REFERENCES `nivell1-pizzeria`.`shops` (`shop_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-pizzeria`.`products` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_description` VARCHAR(45) NOT NULL,
  `product_image` VARCHAR(45) NOT NULL,
  `product_price` INT(11) NOT NULL,
  `orders_order_id` INT(11) NOT NULL,
  `category_category_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`, `orders_order_id`),
  INDEX `fk_products_orders_idx` (`orders_order_id` ASC) VISIBLE,
  INDEX `fk_products_category1_idx` (`category_category_id` ASC) VISIBLE,
  UNIQUE INDEX `category_category_id_UNIQUE` (`category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_orders`
    FOREIGN KEY (`orders_order_id`)
    REFERENCES `nivell1-pizzeria`.`orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_category1`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `nivell1-pizzeria`.`category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `nivell1-pizzeria`.`category` (
  `category_id` INT(11) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
