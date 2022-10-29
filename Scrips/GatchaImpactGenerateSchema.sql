-- noinspection SqlNoDataSourceInspectionForFile

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GatchaImpact
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `GatchaImpact` ;

-- -----------------------------------------------------
-- Schema GatchaImpact
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GatchaImpact` DEFAULT CHARACTER SET utf8 ;
USE `GatchaImpact` ;

-- -----------------------------------------------------
-- Table `GatchaImpact`.`UserCredentials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`UserCredentials` (
  `UserName` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`UserName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GatchaImpact`.`Player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`Player` (
  `PlayerID` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(50) NOT NULL,
  `ScoreBoardID` INT NULL,
  `Money` INT NULL,
  `Mana` INT NULL,
  `QuestCompleteness` FLOAT NULL,
  PRIMARY KEY (`PlayerID`),
  INDEX `fk_Player_UserCredentials1_idx` (`UserName` ASC) VISIBLE,
  CONSTRAINT `fk_Player_UserCredentials1`
    FOREIGN KEY (`UserName`)
    REFERENCES `GatchaImpact`.`UserCredentials` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GatchaImpact`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`Items` (
  `ItemID` INT NOT NULL,
  `Damage` FLOAT NULL,
  `Type` VARCHAR(45) NULL,
  `Value` FLOAT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GatchaImpact`.`NPC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`NPC` (
  `NPCID` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(45) NULL,
  `Health` INT NULL,
  `Mana` INT NULL,
  `Difficulity` INT NULL,
  PRIMARY KEY (`NPCID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GatchaImpact`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`Inventory` (
  `IsPlayer` TINYINT NOT NULL,
  `EntityID` INT NOT NULL,
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Quantity` INT NULL,
  `MainHand` TINYINT NULL,
  `OffHand` TINYINT NULL,
  `Armor` TINYINT NULL,
  PRIMARY KEY (`IsPlayer`, `EntityID`, `ItemID`),
  INDEX `fk_inventory_items1_idx` (`ItemID` ASC) VISIBLE,
  INDEX `fk_Inventory_Player1_idx` (`EntityID` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_items1`
    FOREIGN KEY (`ItemID`)
    REFERENCES `GatchaImpact`.`Items` (`ItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory_Player1`
    FOREIGN KEY (`EntityID`)
    REFERENCES `GatchaImpact`.`Player` (`PlayerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory_NPC1`
    FOREIGN KEY (`EntityID`)
    REFERENCES `GatchaImpact`.`NPC` (`NPCID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GatchaImpact`.`Boss`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`Boss` (
  `BossID` INT NOT NULL AUTO_INCREMENT,
  `NPCID` INT NOT NULL,
  PRIMARY KEY (`BossID`),
  INDEX `fk_Boss_NPC_idx` (`NPCID` ASC) VISIBLE,
  CONSTRAINT `fk_Boss_NPC`
    FOREIGN KEY (`NPCID`)
    REFERENCES `GatchaImpact`.`NPC` (`NPCID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GatchaImpact`.`Quests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`Quests` (
  `QuestID` INT NOT NULL AUTO_INCREMENT,
  `NPCID` INT NULL,
  `PreviousQuest` INT NULL,
  `NextQuest` INT NULL,
  `QuestDescription` VARCHAR(50) NOT NULL,
  `QuestRewardItemID` INT NULL,
  `QuestRewardMoneyAmount` INT NULL,
  PRIMARY KEY (`QuestID`),
  INDEX `fk_Quests_NPC1_idx` (`NPCID` ASC) VISIBLE,
  INDEX `fk_Quests_Items1_idx` (`QuestRewardItemID` ASC) VISIBLE,
  CONSTRAINT `fk_Quests_NPC1`
    FOREIGN KEY (`NPCID`)
    REFERENCES `GatchaImpact`.`NPC` (`NPCID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quests_Items1`
    FOREIGN KEY (`QuestRewardItemID`)
    REFERENCES `GatchaImpact`.`Items` (`ItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GatchaImpact`.`Active Quests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatchaImpact`.`Active Quests` (
  `PlayerID` INT NOT NULL,
  `QuestID` INT NOT NULL,
  PRIMARY KEY (`PlayerID`, `QuestID`),
  INDEX `fk_Active Quests_Quests1_idx` (`QuestID` ASC) VISIBLE,
  INDEX `fk_Active Quests_Player1_idx` (`PlayerID` ASC) VISIBLE,
  CONSTRAINT `fk_Active Quests_Quests1`
    FOREIGN KEY (`QuestID`)
    REFERENCES `GatchaImpact`.`Quests` (`QuestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Active Quests_Player1`
    FOREIGN KEY (`PlayerID`)
    REFERENCES `GatchaImpact`.`Player` (`PlayerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
