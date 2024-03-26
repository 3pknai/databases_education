-- MySQL Script generated by MySQL Workbench
-- Thu Mar 14 01:36:31 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Online learning platform
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Online learning platform
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Online learning platform` DEFAULT CHARACTER SET utf8 ;
USE `Online learning platform` ;

-- -----------------------------------------------------
-- Table `Online learning platform`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`User` (
  `Login` VARCHAR(26) NOT NULL, -- [4, 26]
  `Name` VARCHAR(50) NOT NULL, -- [4, 50]
  `Password` VARCHAR(45) NOT NULL, -- [4, 45]
  `The_time_of_the_last_access_to_the_system` DATETIME NOT NULL, -- < CURRENT_TIME
  `Mail` VARCHAR(50) NOT NULL, -- [4, 50]
  `Date_of_birth` DATE NOT NULL, -- < CURRENT_DATE
  `Telephone` VARCHAR(11) NULL, -- = 11
  `Country` VARCHAR(30) NOT NULL, -- [3, 30]
  `Avatar` VARCHAR(80) NULL,
  PRIMARY KEY (`Login`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Notification` (
  `id_notification` INT NOT NULL AUTO_INCREMENT,
  `Text` MEDIUMTEXT NOT NULL,
  `Name` VARCHAR(50) NOT NULL, -- [1, 50]
  `Date_of_dispatch` DATETIME NOT NULL, -- < CURRENT_TIME
  PRIMARY KEY (`id_notification`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Blog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Blog` (
  `id_blog` INT NOT NULL AUTO_INCREMENT,
  `Date_of_publication` DATETIME NOT NULL,
  `Content` MEDIUMTEXT NOT NULL,
  `Title` VARCHAR(50) NOT NULL, -- [1, 50]
  PRIMARY KEY (`id_blog`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Payment` (
  `id_payment` INT NOT NULL AUTO_INCREMENT,
  `Method` VARCHAR(50) NOT NULL, -- [4, 50]
  `Price` FLOAT NOT NULL, -- >= 0
  `Commission` FLOAT NOT NULL, -- >= 0
  PRIMARY KEY (`id_payment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Forum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Forum` (
  `id_forum` INT NOT NULL AUTO_INCREMENT,
  `Number_of_messages` INT NOT NULL, -- > 0
  `The_subject_of_the_question` VARCHAR(50) NOT NULL, -- [1, 50]
  PRIMARY KEY (`id_forum`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Content bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Content bank` (
  `id_content_bank` INT NOT NULL AUTO_INCREMENT,
  `Access_rights` VARCHAR(45) NOT NULL,
  `Location_on_the_server` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_content_bank`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Course` (
  `Short name` VARCHAR(12) NOT NULL, -- [1, 12]
  `Name` VARCHAR(50) NOT NULL, -- [1, 50]
  `Description` MEDIUMTEXT NULL,
  `Duration` INT NULL, -- > 0 
  `Rating` FLOAT NULL, -- [0, 5]
  `The_beginning_of_the_course` DATETIME NULL,
  `Payment_id_payment` INT NOT NULL,
  `Forum_id_forum` INT NOT NULL,
  `Content bank_id_content_bank` INT NOT NULL,
  PRIMARY KEY (`Short name`),
  INDEX `fk_Course_Payment_idx` (`Payment_id_payment` ASC) VISIBLE,
  INDEX `fk_Course_Forum1_idx` (`Forum_id_forum` ASC) VISIBLE,
  INDEX `fk_Course_Content bank1_idx` (`Content bank_id_content_bank` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Payment`
    FOREIGN KEY (`Payment_id_payment`)
    REFERENCES `Online learning platform`.`Payment` (`id_payment`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Forum1`
    FOREIGN KEY (`Forum_id_forum`)
    REFERENCES `Online learning platform`.`Forum` (`id_forum`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Content bank1`
    FOREIGN KEY (`Content bank_id_content_bank`)
    REFERENCES `Online learning platform`.`Content bank` (`id_content_bank`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Course element`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Course element` (
  `id_course_element` INT NOT NULL AUTO_INCREMENT,
  `Number` INT NOT NULL, -- > 0
  `Name` VARCHAR(50) NOT NULL, -- [1, 50]
  `Type` VARCHAR(50) NOT NULL, -- [1, 50]
  `Visibility` TINYINT NOT NULL,
  `Attached_file` VARCHAR(80) NULL, -- [4, 80]
  `Content bank_id_content_bank` INT NOT NULL,
  PRIMARY KEY (`id_course_element`),
  INDEX `fk_Course element_Content bank1_idx` (`Content bank_id_content_bank` ASC) VISIBLE,
  CONSTRAINT `fk_Course element_Content bank1`
    FOREIGN KEY (`Content bank_id_content_bank`)
    REFERENCES `Online learning platform`.`Content bank` (`id_content_bank`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Testing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Testing` (
  `id_test` INT NOT NULL AUTO_INCREMENT,
  `Start_date` DATETIME NULL,
  `End_date` DATETIME NULL,
  `Content bank_id_content_bank` INT NOT NULL,
  PRIMARY KEY (`id_test`),
  INDEX `fk_Testing_Content bank1_idx` (`Content bank_id_content_bank` ASC) VISIBLE,
  CONSTRAINT `fk_Testing_Content bank1`
    FOREIGN KEY (`Content bank_id_content_bank`)
    REFERENCES `Online learning platform`.`Content bank` (`id_content_bank`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Question` (
  `id_question` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL, -- [1, 30]
  `Text` TEXT NOT NULL,
  `Score_for_correct_execution` FLOAT NOT NULL, -- > 0
  `Creation_time` DATETIME NOT NULL,  -- < CURRENT_TIME
  `Type` VARCHAR(45) NOT NULL, -- переделать
  `The_maximum_size_of_the_file_to_be_added` INT NULL, -- > 0
  `The_maximum_number_of_files_to_add` TINYINT NULL, -- > 0
  PRIMARY KEY (`id_question`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`User to Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`User to Course` (
  `Course_Short name` VARCHAR(45) NOT NULL,
  `User_Login` VARCHAR(26) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Course_Short name`, `User_Login`),
  INDEX `fk_Course_has_User_User1_idx` (`User_Login` ASC) VISIBLE,
  INDEX `fk_Course_has_User_Course1_idx` (`Course_Short name` ASC) VISIBLE,
  CONSTRAINT `fk_Course_has_User_Course1`
    FOREIGN KEY (`Course_Short name`)
    REFERENCES `Online learning platform`.`Course` (`Short name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_has_User_User1`
    FOREIGN KEY (`User_Login`)
    REFERENCES `Online learning platform`.`User` (`Login`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`User to Notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`User to Notification` (
  `User_Login` VARCHAR(26) NOT NULL,
  `Notification_id_notification` INT NOT NULL,
  `Read` TINYINT NOT NULL,
  PRIMARY KEY (`User_Login`, `Notification_id_notification`),
  INDEX `fk_User_has_Notification_Notification1_idx` (`Notification_id_notification` ASC) VISIBLE,
  INDEX `fk_User_has_Notification_User1_idx` (`User_Login` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Notification_User1`
    FOREIGN KEY (`User_Login`)
    REFERENCES `Online learning platform`.`User` (`Login`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_User_has_Notification_Notification1`
    FOREIGN KEY (`Notification_id_notification`)
    REFERENCES `Online learning platform`.`Notification` (`id_notification`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`User to Blog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`User to Blog` (
  `User_Login` VARCHAR(26) NOT NULL,
  `Blog_id_blog` INT NOT NULL,
  `Privilege` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`User_Login`, `Blog_id_blog`),
  INDEX `fk_User_has_Blog_Blog1_idx` (`Blog_id_blog` ASC) VISIBLE,
  INDEX `fk_User_has_Blog_User1_idx` (`User_Login` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Blog_User1`
    FOREIGN KEY (`User_Login`)
    REFERENCES `Online learning platform`.`User` (`Login`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_User_has_Blog_Blog1`
    FOREIGN KEY (`Blog_id_blog`)
    REFERENCES `Online learning platform`.`Blog` (`id_blog`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`User to Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`User to Question` (
  `Question_id_question` INT NOT NULL,
  `User_Login` VARCHAR(26) NOT NULL,
  `The_score_received` INT NOT NULL,
  PRIMARY KEY (`Question_id_question`, `User_Login`),
  INDEX `fk_Question_has_User_User1_idx` (`User_Login` ASC) VISIBLE,
  INDEX `fk_Question_has_User_Question1_idx` (`Question_id_question` ASC) VISIBLE,
  CONSTRAINT `fk_Question_has_User_Question1`
    FOREIGN KEY (`Question_id_question`)
    REFERENCES `Online learning platform`.`Question` (`id_question`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Question_has_User_User1`
    FOREIGN KEY (`User_Login`)
    REFERENCES `Online learning platform`.`User` (`Login`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online learning platform`.`Testing to Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online learning platform`.`Testing to Question` (
  `Testing_id_test` INT NOT NULL,
  `Question_id_question` INT NOT NULL,
  `Number` TINYINT NOT NULL,
  PRIMARY KEY (`Testing_id_test`, `Question_id_question`),
  INDEX `fk_Testing_has_Question_Question1_idx` (`Question_id_question` ASC) VISIBLE,
  INDEX `fk_Testing_has_Question_Testing1_idx` (`Testing_id_test` ASC) VISIBLE,
  CONSTRAINT `fk_Testing_has_Question_Testing1`
    FOREIGN KEY (`Testing_id_test`)
    REFERENCES `Online learning platform`.`Testing` (`id_test`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Testing_has_Question_Question1`
    FOREIGN KEY (`Question_id_question`)
    REFERENCES `Online learning platform`.`Question` (`id_question`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
