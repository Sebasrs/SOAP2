-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema soa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema soa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `soa` DEFAULT CHARACTER SET utf8 ;
USE `soa` ;

-- -----------------------------------------------------
-- Table `soa`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soa`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soa`.`provinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soa`.`provinces` (
  `idProvince` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Country_idCountry` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `Provincecol` VARCHAR(45) NULL,
  PRIMARY KEY (`idProvince`),
  INDEX `fk_Province_Country1_idx` (`Country_idCountry` ASC),
  CONSTRAINT `fk_Province_Country1`
    FOREIGN KEY (`Country_idCountry`)
    REFERENCES `soa`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soa`.`restaurants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soa`.`restaurants` (
  `idRestaurant` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `contactNumber` VARCHAR(45) NOT NULL,
  `disponibilityDays` VARCHAR(45) NOT NULL,
  `disponibilityHours` VARCHAR(45) NOT NULL,
  `Province_idProvince` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idRestaurant`),
  INDEX `fk_Restaurant_Province1_idx` (`Province_idProvince` ASC),
  CONSTRAINT `fk_Restaurant_Province1`
    FOREIGN KEY (`Province_idProvince`)
    REFERENCES `soa`.`provinces` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soa`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soa`.`clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `fName` VARCHAR(45) NOT NULL,
  `lName` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `identification` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idClient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soa`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soa`.`users` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `Client_idClient` INT NOT NULL,
  `Restaurant_idRestaurant` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `fk_User_Client1_idx` (`Client_idClient` ASC),
  INDEX `fk_User_Restaurant1_idx` (`Restaurant_idRestaurant` ASC),
  CONSTRAINT `fk_User_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `soa`.`clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Restaurant1`
    FOREIGN KEY (`Restaurant_idRestaurant`)
    REFERENCES `soa`.`restaurants` (`idRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE orders (
  idOrder INT PRIMARY KEY AUTO_INCREMENT,
  idRestaurant INT,
  idClient INT,
  orderDate DATETIME DEFAULT   CURRENT_TIMESTAMP,
  FOREIGN KEY (idRestaurant) REFERENCES restaurants(idRestaurant),
  FOREIGN KEY (idClient) REFERENCES clients(idClient)
)
 

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
