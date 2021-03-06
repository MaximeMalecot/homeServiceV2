-- MySQL Script generated by MySQL Workbench
-- Sun Mar  1 23:23:29 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`categorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categorie` (
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nom`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prestation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prestation` (
  `id_prestation` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(150) NULL DEFAULT NULL,
  `categorie_nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_prestation`),
  INDEX `fk_prestation_categorie1_idx` (`categorie_nom` ASC) ,
  CONSTRAINT `fk_prestation_categorie1`
    FOREIGN KEY (`categorie_nom`)
    REFERENCES `mydb`.`categorie` (`nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prestataire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prestataire` (
  `id_prestataire` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `tel_mobile` VARCHAR(45) NULL DEFAULT NULL,
  `tel_fixe` VARCHAR(45) NULL DEFAULT NULL,
  `adresse_entreprise` VARCHAR(45) NULL DEFAULT NULL,
  `url_qrcode` VARCHAR(45) NULL DEFAULT NULL,
  `prix_heure` FLOAT NULL DEFAULT NULL,
  `supplement` VARCHAR(45) NULL DEFAULT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `company_name` VARCHAR(45) NULL,
  `code_postal` INT NULL,
  `categorie_nom` VARCHAR(45) NOT NULL,
  `email` VARCHAR(60) NULL,
  `nb_heure_min` FLOAT NULL,
  `prix_recurrent` VARCHAR(45) NULL,
  PRIMARY KEY (`id_prestataire`, `ville`),
  INDEX `fk_prestataire_categorie1_idx` (`categorie_nom` ASC) ,
  CONSTRAINT `fk_prestataire_categorie1`
    FOREIGN KEY (`categorie_nom`)
    REFERENCES `mydb`.`categorie` (`nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `prenom` VARCHAR(45) NULL DEFAULT NULL,
  `mdp` VARCHAR(256) NULL,
  `mail` VARCHAR(45) NULL DEFAULT NULL,
  `date_inscription` DATETIME NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL,
  `adresse` VARCHAR(45) NULL,
  `cp` INT NULL,
  `statut` VARCHAR(45) NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`abonnement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`abonnement` (
  `id_abonnement` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `cout` FLOAT NULL DEFAULT NULL,
  `nb_heure` FLOAT NULL DEFAULT NULL,
  `temps` INT NULL,
  `heure_debut` INT NULL,
  `heure_fin` INT NULL,
  PRIMARY KEY (`id_abonnement`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservation` (
  `id_reservation` INT NOT NULL AUTO_INCREMENT,
  `date_debut` DATETIME NULL,
  `date_fin` DATETIME NULL,
  `prestation_id_prestation` INT NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_reservation`),
  INDEX `fk_reservation_prestation1_idx` (`prestation_id_prestation` ASC) ,
  INDEX `fk_reservation_client1_idx` (`id_user` ASC) ,
  CONSTRAINT `fk_reservation_prestation1`
    FOREIGN KEY (`prestation_id_prestation`)
    REFERENCES `mydb`.`prestation` (`id_prestation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_client1`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`facturation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`facturation` (
  `id_facturation` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NULL DEFAULT NULL,
  `cout` FLOAT NULL DEFAULT NULL,
  `id_user` INT NOT NULL,
  `prestataire_id_prestataire` INT NULL,
  `devis` INT NULL,
  `reservation_id_reservation` INT NOT NULL,
  PRIMARY KEY (`id_facturation`),
  INDEX `fk_facturation_client1_idx` (`id_user` ASC) ,
  INDEX `fk_facturation_prestataire1_idx` (`prestataire_id_prestataire` ASC) ,
  INDEX `fk_facturation_reservation1_idx` (`reservation_id_reservation` ASC) ,
  CONSTRAINT `fk_facturation_client1`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturation_prestataire1`
    FOREIGN KEY (`prestataire_id_prestataire`)
    REFERENCES `mydb`.`prestataire` (`id_prestataire`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturation_reservation1`
    FOREIGN KEY (`reservation_id_reservation`)
    REFERENCES `mydb`.`reservation` (`id_reservation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`contrat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contrat` (
  `id_contrat` INT NOT NULL AUTO_INCREMENT,
  `duree` INT NULL DEFAULT NULL,
  `path_contrat` VARCHAR(45) NULL DEFAULT NULL,
  `prestataire_id_prestataire` INT NOT NULL,
  `salaire` FLOAT NULL,
  `date_debut` DATETIME NULL,
  `date_fin` DATETIME NULL,
  PRIMARY KEY (`id_contrat`),
  INDEX `fk_contrat_prestataire1_idx` (`prestataire_id_prestataire` ASC) ,
  CONSTRAINT `fk_contrat_prestataire1`
    FOREIGN KEY (`prestataire_id_prestataire`)
    REFERENCES `mydb`.`prestataire` (`id_prestataire`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`souscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`souscription` (
  `id_user` INT NOT NULL,
  `abonnement_id_abonnement` INT NOT NULL,
  `date` DATETIME NULL,
  `heure_restante` FLOAT NULL,
  INDEX `fk_client_has_abonnement_abonnement1_idx` (`abonnement_id_abonnement` ASC) ,
  INDEX `fk_client_has_abonnement_client1_idx` (`id_user` ASC) ,
  PRIMARY KEY (`abonnement_id_abonnement`, `id_user`),
  CONSTRAINT `fk_client_has_abonnement_client1`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_abonnement_abonnement1`
    FOREIGN KEY (`abonnement_id_abonnement`)
    REFERENCES `mydb`.`abonnement` (`id_abonnement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`demande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`demande` (
  `id_demande` INT NOT NULL AUTO_INCREMENT,
  `description` LONGTEXT NULL,
  `date` DATETIME NULL,
  `etat` TINYINT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_demande`),
  INDEX `fk_demande_client1_idx` (`id_user` ASC) ,
  CONSTRAINT `fk_demande_client1`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
