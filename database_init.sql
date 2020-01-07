-- MySQL Script generated by MySQL Workbench
-- Tue Dec 17 11:02:58 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE=`ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION`;

-- -----------------------------------------------------
-- Schema trawell
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `trawell` ;

-- -----------------------------------------------------
-- Schema trawell
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `trawell` DEFAULT CHARACTER SET utf8;
USE `trawell` ;

-- -----------------------------------------------------
-- Table `trawell`.`Ad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`ad` ;

CREATE TABLE IF NOT EXISTS `trawell`.`ad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT NOT NULL,
  `ad_payment_method` VARCHAR(60) NOT NULL,
  `ad_cost` INT NOT NULL,
  `ad_starting_date` DATETIME NOT NULL,
  `ad_due_date` DATETIME NOT NULL,
  `id_photo` VARCHAR(268) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_ad_UNIQUE` (`id` ASC),
  INDEX `id_user_idx` (`id_owner` ASC),
    FOREIGN KEY (`id_owner`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `trawell`.`BanData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`ban_data` ;

CREATE TABLE IF NOT EXISTS `trawell`.`ban_data` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `id_admin` INT NOT NULL,
  `id_user` INT NOT NULL,
  `ban_until` DATETIME NOT NULL,
  `motivation` VARCHAR(450) NOT NULL,
    PRIMARY KEY (`id`),
   
    FOREIGN KEY (`id_user`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`id_admin`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`CarSharing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`carsharing` ;

CREATE TABLE IF NOT EXISTS `trawell`.`carsharing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `departure_date` DATETIME NOT NULL,
  `description` VARCHAR(500),
  `departure` VARCHAR(45) NOT NULL,
  `arrival` VARCHAR(45) NOT NULL,
  `carsharingspot` INT NOT NULL,
  `id_owner` INT,
  FOREIGN KEY (`id_owner`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`CarSpot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`carspot` ;

CREATE TABLE IF NOT EXISTS `trawell`.`carspot` (
  `id_user` INT NOT NULL,
  `id_carsharing` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_carsharing`),
 
    FOREIGN KEY (`id_user`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 
    FOREIGN KEY (`id_carsharing`)
    REFERENCES `trawell`.`carsharing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`chat` ;

CREATE TABLE IF NOT EXISTS `trawell`.`chat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idSender` INT NOT NULL,
  `idReciver` INT NOT NULL,
  UNIQUE INDEX `idChat_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `idSender_idx` (`idSender` ASC),
  INDEX `idReciver_idx` (`idReciver` ASC),
 
    FOREIGN KEY (`id`)
    REFERENCES `trawell`.`Message` (`idChat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 
    FOREIGN KEY (`idSender`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  
    FOREIGN KEY (`idReciver`)
    REFERENCES `trawell`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Complaint`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`complaint` ;

CREATE TABLE IF NOT EXISTS `trawell`.`complaint` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `complaint_object` VARCHAR(45) NOT NULL,
  `complaint_description` TEXT NOT NULL,
  `complaint_mail` VARCHAR (254) NOT NULL,
  `id_answerer` INT,
  `complaint_answered` TINYINT NOT NULL DEFAULT 0,
  `complaint_answere` TEXT, 
  PRIMARY KEY (`id`),  
    FOREIGN KEY (`id_user`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`destination` ;

CREATE TABLE IF NOT EXISTS `trawell`.`destination` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_itinerary` INT,
  `location` VARCHAR(50) NOT NULL,
  `description` VARCHAR(450) NULL,
  `date` DATETIME NOT NULL,
  `is_visited` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
 
    FOREIGN KEY (`id_itinerary`)
    REFERENCES `trawell`.`itinerary` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Document`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`document` ;

CREATE TABLE IF NOT EXISTS `trawell`.`document` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_wallet` INT NOT NULL,
  `id_user` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `path` VARCHAR(268) NOT NULL,
  `due_date` DATETIME NULL,
  `note` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_document_UNIQUE` (`id` ASC),
  INDEX `id_wallet_idx` (`id_wallet` ASC),
 
    FOREIGN KEY (`id_wallet`)
    REFERENCES `trawell`.`wallet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, 

    FOREIGN KEY (`id_user`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`trawell_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`trawell_group` ;

CREATE TABLE IF NOT EXISTS `trawell`.`trawell_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(500) NULL,
  `id_itinerary` INT NOT NULL,
  PRIMARY KEY (`id`),

    FOREIGN KEY (`id_itinerary`)
    REFERENCES `trawell`.`itinerary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    
    FOREIGN KEY (`id_owner`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`GroupMember`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`groupMember` ;

CREATE TABLE IF NOT EXISTS `trawell`.`groupMember` (
  `id_user` INT NOT NULL,
  `id_group` INT NOT NULL,
  
    FOREIGN KEY (`id_group`)
    REFERENCES `trawell`.`trawell_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  
    FOREIGN KEY (`id_user`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Itinerary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`itinerary` ;

CREATE TABLE IF NOT EXISTS `trawell`.`itinerary` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT,
  `name` VARCHAR(50) NOT NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_owner`)
  REFERENCES `trawell`.`user` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`message` ;

CREATE TABLE IF NOT EXISTS `trawell`.`message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Message` VARCHAR(450) NOT NULL,
  `idPhoto` INT NOT NULL,
  `idChat` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idMessage_UNIQUE` (`id` ASC),
  INDEX `fk_Message_Photo1_idx` (`idPhoto` ASC),
  UNIQUE INDEX `idChat_UNIQUE` (`idChat` ASC),
 
    FOREIGN KEY (`idPhoto`)
    REFERENCES `trawell`.`Photo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`photo` ;

CREATE TABLE IF NOT EXISTS `trawell`.`photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idOwner` INT NOT NULL,
  `PhotoName` VARCHAR(100) NOT NULL,
  `PhotoPath` VARCHAR(268) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idPhoto_UNIQUE` (`id` ASC),
  UNIQUE INDEX `PhotoPhat_UNIQUE` (`PhotoPath` ASC),
  INDEX `idOwner_idx` (`idOwner` ASC),
 
    FOREIGN KEY (`idOwner`)
    REFERENCES `trawell`.`Post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trawell`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`post` ;

CREATE TABLE IF NOT EXISTS `trawell`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT NOT NULL,
  `id_group` INT ,
  `id_photo` INT NULL,
  `post_description` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`),
  
    FOREIGN KEY (`id_owner`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 
    FOREIGN KEY (`id_group`)
    REFERENCES `trawell`.`trawell_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `trawell`.`user`;
-- -----------------------------------------------------
-- Table `trawell`.`User`
-- -----------------------------------------------------
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(254) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `birth` datetime NOT NULL,
  `banned` tinyint(4) NOT NULL DEFAULT '0',
  `bio` varchar(5000) DEFAULT NULL,
  `profile_photo` int(11) DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT '0',
  `is_banned` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idUser_UNIQUE` (`id`),
  UNIQUE KEY `mail_UNIQUE` (`mail`),
  UNIQUE KEY `userName_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO user VALUES (1,'umbertorussomando@gmail.com','admin','09F43236BB5E2B75230E705C39EDBB71','Umberto','Russomando','1997-11-09 00:00:00',0,NULL,0,'3347877736',1,0);
-- -----------------------------------------------------
-- Table `trawell`.`AgencyData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`agency` ;

CREATE TABLE IF NOT EXISTS `trawell`.`agency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_agency` VARCHAR(100) default null,
  `url` VARCHAR(2083) default null,
  `vat` VARCHAR(20) default null,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id`)
    REFERENCES `trawell`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `trawell`.`Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trawell`.`wallet` ;

CREATE TABLE IF NOT EXISTS `trawell`.`wallet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_owner` INT,
  `id_group` INT NOT NULL,
  `is_private` TINYINT DEFAULT 1,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`id_owner`) REFERENCES `trawell`.`user` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`id_group`) REFERENCES `trawell`.`trawell_group` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

  )
  
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;