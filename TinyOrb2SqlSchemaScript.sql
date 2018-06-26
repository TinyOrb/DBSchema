SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `TinyOrb2` ;
CREATE SCHEMA IF NOT EXISTS `TinyOrb2` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `TinyOrb2` ;

-- -----------------------------------------------------
-- Table `TinyOrb2`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`user` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `Email` VARCHAR(45) NOT NULL ,
  `Password` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`iduser`, `Email`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`userprofile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`userprofile` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`userprofile` (
  `username` VARCHAR(45) NOT NULL ,
  `first_name` VARCHAR(45) NOT NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `Country` VARCHAR(45) NULL ,
  `State` VARCHAR(45) NULL ,
  `Gender` VARCHAR(15) NULL ,
  `AEmail` VARCHAR(45) NULL ,
  `DOB` DATE NULL ,
  PRIMARY KEY (`username`) ,
  INDEX `username` (`username` ASC) ,
  CONSTRAINT `username`
    FOREIGN KEY (`username` )
    REFERENCES `TinyOrb2`.`user` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`Article` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`Article` (
  `idArticle` INT NOT NULL AUTO_INCREMENT ,
  `Category` VARCHAR(45) NULL ,
  `Author` VARCHAR(45) NOT NULL ,
  `LastModified` VARCHAR(45) NOT NULL ,
  `saveData` LONGTEXT NULL ,
  `Heading` VARCHAR(200) NULL ,
  `PubId` INT NULL DEFAULT -1 ,
  PRIMARY KEY (`idArticle`) ,
  INDEX `Author` (`Author` ASC) ,
  CONSTRAINT `Author`
    FOREIGN KEY (`Author` )
    REFERENCES `TinyOrb2`.`user` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`Search_Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`Search_Tag` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`Search_Tag` (
  `tag` VARCHAR(100) NOT NULL ,
  `ArticleID` INT NOT NULL ,
  INDEX `ArticleID` (`ArticleID` ASC) ,
  CONSTRAINT `ArticleID`
    FOREIGN KEY (`ArticleID` )
    REFERENCES `TinyOrb2`.`Article` (`idArticle` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`Publish_Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`Publish_Post` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`Publish_Post` (
  `idPublish_Post` INT NOT NULL AUTO_INCREMENT ,
  `Rating` FLOAT NULL ,
  `Tags` VARCHAR(200) NULL ,
  `ViewCount` INT NULL ,
  `RateCount` INT NULL ,
  `PAuthor` VARCHAR(45) NOT NULL ,
  `Date` DATE NOT NULL ,
  `Heading` VARCHAR(200) NOT NULL ,
  `Category` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`idPublish_Post`) ,
  INDEX `PAuthor` (`PAuthor` ASC) ,
  CONSTRAINT `PAuthor`
    FOREIGN KEY (`PAuthor` )
    REFERENCES `TinyOrb2`.`user` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`Public_Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`Public_Comment` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`Public_Comment` (
  `idPublic_Comment` INT NOT NULL ,
  `Comment user` VARCHAR(45) NULL ,
  `PID` INT NOT NULL ,
  PRIMARY KEY (`idPublic_Comment`) ,
  INDEX `PID` (`PID` ASC) ,
  CONSTRAINT `PID`
    FOREIGN KEY (`PID` )
    REFERENCES `TinyOrb2`.`Publish_Post` (`idPublish_Post` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`Inquiry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`Inquiry` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`Inquiry` (
  `idInquiry` INT NOT NULL AUTO_INCREMENT ,
  `user` VARCHAR(45) NOT NULL ,
  `type` VARCHAR(45) NOT NULL ,
  `title` VARCHAR(45) NOT NULL ,
  `description` LONGTEXT NOT NULL ,
  `opendate` DATE NOT NULL ,
  `closedate` DATE NULL ,
  `openstatus` TINYINT(1) NOT NULL ,
  `reopendate` DATE NULL ,
  PRIMARY KEY (`idInquiry`) ,
  INDEX `user` (`user` ASC) ,
  CONSTRAINT `user`
    FOREIGN KEY (`user` )
    REFERENCES `TinyOrb2`.`user` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`PasswordChangeRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`PasswordChangeRequest` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`PasswordChangeRequest` (
  `idChangeRequest` INT NOT NULL AUTO_INCREMENT ,
  `RequestCode` VARCHAR(45) NOT NULL ,
  `RequestedDate` DATETIME NOT NULL ,
  `RequestedUser` VARCHAR(45) NOT NULL ,
  `Requested` TINYINT(1) NOT NULL DEFAULT false ,
  PRIMARY KEY (`idChangeRequest`) ,
  INDEX `RequestedUser` (`RequestedUser` ASC) ,
  CONSTRAINT `RequestedUser`
    FOREIGN KEY (`RequestedUser` )
    REFERENCES `TinyOrb2`.`user` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`CodeTable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`CodeTable` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`CodeTable` (
  `idCodeTable` VARCHAR(10) NOT NULL ,
  `Code` VARCHAR(45) NOT NULL ,
  `GenerateTime` DATETIME NOT NULL ,
  `ExpireTime` DATETIME NOT NULL ,
  PRIMARY KEY (`idCodeTable`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyOrb2`.`UserVerification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyOrb2`.`UserVerification` ;

CREATE  TABLE IF NOT EXISTS `TinyOrb2`.`UserVerification` (
  `Username` VARCHAR(45) NOT NULL ,
  `CreateDate` DATETIME NOT NULL ,
  `VerificationStatus` TINYINT(1) NOT NULL DEFAULT false ,
  `VerifiedDate` DATETIME NULL ,
  `VerificationCode` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`Username`) ,
  INDEX `username_uk` (`Username` ASC) ,
  CONSTRAINT `username_uk`
    FOREIGN KEY (`Username` )
    REFERENCES `TinyOrb2`.`user` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- procedure GetPasswordRequestCode
-- -----------------------------------------------------

USE `TinyOrb2`;
DROP procedure IF EXISTS `TinyOrb2`.`GetPasswordRequestCode`;

DELIMITER $$
USE `TinyOrb2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPasswordRequestCode`(IN username VARCHAR(45))
BEGIN
    DECLARE Code VARCHAR(45) DEFAULT SUBSTRING(md5(rand()) from 1 for 10+ROUND(100*rand()%5));
    DECLARE date DATETIME;
    SET date = Now();
    insert into `passwordchangerequest` (RequestCode, RequestedDate, RequestedUser, Requested) VALUES(Code, date, username, false);
    Select * from `passwordchangerequest` where `RequestedUser`=username and RequestedDate = date;
END
$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateCode
-- -----------------------------------------------------

USE `TinyOrb2`;
DROP procedure IF EXISTS `TinyOrb2`.`UpdateCode`;

DELIMITER $$
USE `TinyOrb2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCode`()
BEGIN
    DECLARE New_Code VARCHAR(45) DEFAULT "";
    DECLARE Codee VARCHAR(45) DEFAULT NULL;
    DECLARE GT DATETIME;
    DECLARE ET DATETIME;
    select Code from `CodeTable` where `idCodeTable` = "Current";
    if ((select `Code` from `CodeTable` where `idCodeTable` = "Current") is NULL) THEN
        SET New_Code = (select SUBSTRING(md5(rand()) from 1 for 10+ROUND(100*rand()%5)));
        INSERT INTO `CodeTable` (`idCodeTable`, `Code`, `GenerateTime`, `ExpireTime`) VALUES ('Current', New_Code, Now(), DATE_ADD(Now(), INTERVAL 30 MINUTE));
        SET New_Code = (select SUBSTRING(md5(rand()) from 1 for 10+ROUND(100*rand()%5)));
        INSERT INTO `CodeTable` (`idCodeTable`, `Code`, `GenerateTime`, `ExpireTime`) VALUES ('Buffer', New_Code, Now(), DATE_ADD(Now(), INTERVAL 30 MINUTE));
    else
        SET Codee = (select `Code` from `CodeTable` where `idCodeTable` = "Current");
        SET GT = (select `GenerateTime` from `CodeTable` where `idCodeTable` = "Current");
        SET ET = (select `ExpireTime` from `CodeTable` where `idCodeTable` = "Current");
        DELETE from `CodeTable` where `idCodeTable` = "Buffer";
        #UPDATE `table_name` SET `column_name` = `new_value' [WHERE condition];
        Insert into `CodeTable` (`idCodeTable`, `Code`, `GenerateTime`, `ExpireTime`) VALUES ('Buffer', Codee, GT, ET);
        DELETE from `CodeTable` where `idCodeTable` = "Current";
        SET New_Code = (select SUBSTRING(md5(rand()) from 1 for 10+ROUND(100*rand()%5)));
        INSERT INTO `CodeTable` (`idCodeTable`, `Code`, `GenerateTime`, `ExpireTime`) VALUES ('Current', New_Code, Now(), DATE_ADD(Now(), INTERVAL 30 MINUTE));
    end if;
END
$$

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
