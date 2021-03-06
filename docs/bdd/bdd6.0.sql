-- MySQL Script generated by MySQL Workbench
-- Sat Apr 18 22:06:50 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_lille
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_lille
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_lille` DEFAULT CHARACTER SET utf8 ;
USE `db_lille` ;

-- -----------------------------------------------------
-- Table `db_lille`.`abonnement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`abonnement` (
  `id_abonnement` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `cout` FLOAT NULL DEFAULT NULL,
  `nb_heure` FLOAT NULL DEFAULT NULL,
  `temps` INT(11) NULL DEFAULT NULL,
  `heure_debut` INT(11) NULL DEFAULT NULL,
  `heure_fin` INT(11) NULL DEFAULT NULL,
  `stripe_id` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_abonnement`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`categorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`categorie` (
  `nom` VARCHAR(45) NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ville`, `nom`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`prestataire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`prestataire` (
  `id_prestataire` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `tel_mobile` VARCHAR(45) NULL DEFAULT NULL,
  `tel_fixe` VARCHAR(45) NULL DEFAULT NULL,
  `adresse_entreprise` VARCHAR(45) NULL DEFAULT NULL,
  `url_qrcode` VARCHAR(45) NULL DEFAULT NULL,
  `prix_heure` FLOAT NULL DEFAULT NULL,
  `supplement` VARCHAR(45) NULL DEFAULT NULL,
  `company_name` VARCHAR(45) NULL DEFAULT NULL,
  `code_postal` INT(11) NULL DEFAULT NULL,
  `email` VARCHAR(60) NULL DEFAULT NULL,
  `nb_heure_min` FLOAT NULL DEFAULT NULL,
  `prix_recurrent` VARCHAR(45) NULL DEFAULT NULL,
  `categorie_ville` VARCHAR(45) NOT NULL,
  `categorie_nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_prestataire`, `categorie_ville`, `categorie_nom`),
  INDEX `fk_prestataire_categorie1_idx` (`categorie_ville` ASC, `categorie_nom` ASC) ,
  CONSTRAINT `fk_prestataire_categorie1`
    FOREIGN KEY (`categorie_ville` , `categorie_nom`)
    REFERENCES `db_lille`.`categorie` (`ville` , `nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`contrat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`contrat` (
  `id_contrat` INT(11) NOT NULL AUTO_INCREMENT,
  `duree` INT(11) NULL DEFAULT NULL,
  `path_contrat` VARCHAR(45) NULL DEFAULT NULL,
  `salaire` FLOAT NULL DEFAULT NULL,
  `date_debut` DATETIME NULL DEFAULT NULL,
  `date_fin` DATETIME NULL DEFAULT NULL,
  `prestataire_id_prestataire` INT(11) NOT NULL,
  `prestataire_ville` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_contrat`, `prestataire_id_prestataire`, `prestataire_ville`),
  INDEX `fk_contrat_prestataire1_idx` (`prestataire_id_prestataire` ASC, `prestataire_ville` ASC) ,
  CONSTRAINT `fk_contrat_prestataire1`
    FOREIGN KEY (`prestataire_id_prestataire`)
    REFERENCES `db_lille`.`prestataire` (`id_prestataire`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`user` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT,
  `ville_reference` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `prenom` VARCHAR(45) NULL DEFAULT NULL,
  `mdp` VARCHAR(256) NULL DEFAULT NULL,
  `mail` VARCHAR(45) NULL DEFAULT NULL,
  `date_inscription` DATETIME NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `adresse` VARCHAR(45) NULL DEFAULT NULL,
  `cp` INT(11) NULL DEFAULT NULL,
  `statut` VARCHAR(45) NULL DEFAULT NULL,
  `stripe_id` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`, `ville_reference`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`demande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`demande` (
  `id_demande` INT(11) NOT NULL AUTO_INCREMENT,
  `description` LONGTEXT NULL DEFAULT NULL,
  `date` DATETIME NULL DEFAULT NULL,
  `etat` TINYINT(4) NULL DEFAULT NULL,
  `user_id_user` INT(11) NOT NULL,
  `user_ville_reference` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_demande`, `user_id_user`, `user_ville_reference`),
  INDEX `fk_demande_user1_idx` (`user_id_user` ASC, `user_ville_reference` ASC) ,
  CONSTRAINT `fk_demande_user1`
    FOREIGN KEY (`user_id_user` , `user_ville_reference`)
    REFERENCES `db_lille`.`user` (`id_user` , `ville_reference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`bareme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`bareme` (
  `id_bareme` INT NOT NULL AUTO_INCREMENT,
  `unite` VARCHAR(45) NULL DEFAULT NULL,
  `prix_unite` FLOAT NULL DEFAULT NULL,
  `prix_unit_recurrent` FLOAT NULL DEFAULT NULL,
  `nb_unite_minimum` FLOAT NULL DEFAULT NULL,
  `time_per_unit` FLOAT NULL,
  PRIMARY KEY (`id_bareme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_lille`.`prestation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`prestation` (
  `id_prestation` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(150) NULL DEFAULT NULL,
  `categorie_ville` VARCHAR(45) NOT NULL,
  `categorie_nom` VARCHAR(45) NOT NULL,
  `bareme_id_bareme` INT NULL,
  PRIMARY KEY (`id_prestation`, `categorie_ville`, `categorie_nom`),
  INDEX `fk_prestation_categorie1_idx` (`categorie_ville` ASC, `categorie_nom` ASC) ,
  INDEX `fk_prestation_bareme1_idx` (`bareme_id_bareme` ASC) ,
  CONSTRAINT `fk_prestation_categorie1`
    FOREIGN KEY (`categorie_ville` , `categorie_nom`)
    REFERENCES `db_lille`.`categorie` (`ville` , `nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestation_bareme1`
    FOREIGN KEY (`bareme_id_bareme`)
    REFERENCES `db_lille`.`bareme` (`id_bareme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`reservation` (
  `id_reservation` INT(11) NOT NULL AUTO_INCREMENT,
  `date_debut` DATETIME NULL DEFAULT NULL,
  `date_fin` DATETIME NULL DEFAULT NULL,
  `nb_unite` INT(11) NOT NULL,
  `id_supplement` INT NULL DEFAULT NULL,
  `user_id_user` INT(11) NOT NULL,
  `user_ville_reference` VARCHAR(45) NOT NULL,
  `prestation_id_prestation` INT(11) NOT NULL,
  `prestation_ville` VARCHAR(45) NOT NULL,
  `nb_unit_suplement` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id_reservation`, `user_id_user`, `user_ville_reference`, `prestation_id_prestation`, `prestation_ville`),
  INDEX `fk_reservation_user1_idx` (`user_id_user` ASC, `user_ville_reference` ASC) ,
  INDEX `fk_reservation_prestation1_idx` (`prestation_id_prestation` ASC, `prestation_ville` ASC) ,
  CONSTRAINT `fk_reservation_prestation1`
    FOREIGN KEY (`prestation_id_prestation`)
    REFERENCES `db_lille`.`prestation` (`id_prestation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_user1`
    FOREIGN KEY (`user_id_user` , `user_ville_reference`)
    REFERENCES `db_lille`.`user` (`id_user` , `ville_reference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`facturation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`facturation` (
  `id_facturation` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATETIME NULL DEFAULT NULL,
  `cout` FLOAT NULL DEFAULT NULL,
  `id_user` INT(11) NOT NULL,
  `reservation_id_reservation` INT(11) NOT NULL,
  `prestataire_id_prestataire` INT(11) NULL DEFAULT NULL,
  `prestataire_ville` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_facturation`),
  INDEX `fk_facturation_client1_idx` (`id_user` ASC) ,
  INDEX `fk_facturation_reservation1_idx` (`reservation_id_reservation` ASC) ,
  INDEX `fk_facturation_prestataire1_idx` (`prestataire_id_prestataire` ASC, `prestataire_ville` ASC) ,
  CONSTRAINT `fk_facturation_client1`
    FOREIGN KEY (`id_user`)
    REFERENCES `db_lille`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturation_prestataire1`
    FOREIGN KEY (`prestataire_id_prestataire`)
    REFERENCES `db_lille`.`prestataire` (`id_prestataire`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturation_reservation1`
    FOREIGN KEY (`reservation_id_reservation`)
    REFERENCES `db_lille`.`reservation` (`id_reservation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`souscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`souscription` (
  `abonnement_id_abonnement` INT(11) NOT NULL,
  `date` DATETIME NULL DEFAULT NULL,
  `heure_restante` FLOAT NULL DEFAULT NULL,
  `user_id_user` INT(11) NOT NULL,
  `user_ville_reference` VARCHAR(45) NOT NULL,
  `stripe_id` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`abonnement_id_abonnement`, `user_id_user`, `user_ville_reference`),
  INDEX `fk_client_has_abonnement_abonnement1_idx` (`abonnement_id_abonnement` ASC) ,
  INDEX `fk_souscription_user1_idx` (`user_id_user` ASC, `user_ville_reference` ASC) ,
  CONSTRAINT `fk_client_has_abonnement_abonnement1`
    FOREIGN KEY (`abonnement_id_abonnement`)
    REFERENCES `db_lille`.`abonnement` (`id_abonnement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_souscription_user1`
    FOREIGN KEY (`user_id_user` , `user_ville_reference`)
    REFERENCES `db_lille`.`user` (`id_user` , `ville_reference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`supplement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`supplement` (
  `id_supplement` INT NOT NULL AUTO_INCREMENT,
  `bareme_id_bareme` INT NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `unite` VARCHAR(45) NULL DEFAULT NULL,
  `prix_unite` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id_supplement`, `bareme_id_bareme`),
  INDEX `fk_supplement_bareme1_idx` (`bareme_id_bareme` ASC) ,
  CONSTRAINT `fk_supplement_bareme1`
    FOREIGN KEY (`bareme_id_bareme`)
    REFERENCES `db_lille`.`bareme` (`id_bareme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_lille`.`affectation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`affectation` (
  `prestataire_id_prestataire` INT(11) NOT NULL,
  `prestataire_categorie_ville` VARCHAR(45) NOT NULL,
  `prestataire_categorie_nom` VARCHAR(45) NOT NULL,
  `prestation_id_prestation` INT(11) NOT NULL,
  `prestation_categorie_ville` VARCHAR(45) NOT NULL,
  `prestation_categorie_nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`prestataire_id_prestataire`, `prestataire_categorie_ville`, `prestataire_categorie_nom`, `prestation_id_prestation`, `prestation_categorie_ville`, `prestation_categorie_nom`),
  INDEX `fk_affectation_prestataire1_idx` (`prestataire_id_prestataire` ASC, `prestataire_categorie_ville` ASC, `prestataire_categorie_nom` ASC) ,
  INDEX `fk_affectation_prestation1_idx` (`prestation_id_prestation` ASC, `prestation_categorie_ville` ASC, `prestation_categorie_nom` ASC) ,
  CONSTRAINT `fk_affectation_prestataire1`
    FOREIGN KEY (`prestataire_id_prestataire` , `prestataire_categorie_ville` , `prestataire_categorie_nom`)
    REFERENCES `db_lille`.`prestataire` (`id_prestataire` , `categorie_ville` , `categorie_nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_affectation_prestation1`
    FOREIGN KEY (`prestation_id_prestation` , `prestation_categorie_ville` , `prestation_categorie_nom`)
    REFERENCES `db_lille`.`prestation` (`id_prestation` , `categorie_ville` , `categorie_nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_lille`.`Devis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`Devis` (
  `idDevis` INT NOT NULL,
  `date` DATETIME NULL DEFAULT NULL,
  `cout` FLOAT NULL DEFAULT NULL,
  `date_debut` DATETIME NULL DEFAULT NULL,
  `date_fin` DATETIME NULL DEFAULT NULL,
  `nb_unite` INT NULL DEFAULT NULL,
  `id_supplement` INT NULL DEFAULT NULL,
  `nb_unit_supplement` FLOAT NULL DEFAULT NULL,
  `prestation_id_prestation` INT(11) NOT NULL,
  `prestation_categorie_ville` VARCHAR(45) NOT NULL,
  `prestation_categorie_nom` VARCHAR(45) NOT NULL,
  `user_id_user` INT(11) NOT NULL,
  `user_ville_reference` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDevis`, `prestation_id_prestation`, `prestation_categorie_ville`, `prestation_categorie_nom`, `user_id_user`, `user_ville_reference`),
  INDEX `fk_Devis_prestation1_idx` (`prestation_id_prestation` ASC, `prestation_categorie_ville` ASC, `prestation_categorie_nom` ASC) ,
  INDEX `fk_Devis_user1_idx` (`user_id_user` ASC, `user_ville_reference` ASC) ,
  CONSTRAINT `fk_Devis_prestation1`
    FOREIGN KEY (`prestation_id_prestation` , `prestation_categorie_ville` , `prestation_categorie_nom`)
    REFERENCES `db_lille`.`prestation` (`id_prestation` , `categorie_ville` , `categorie_nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Devis_user1`
    FOREIGN KEY (`user_id_user` , `user_ville_reference`)
    REFERENCES `db_lille`.`user` (`id_user` , `ville_reference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_lille`.`planning`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_lille`.`planning` (
  `id_planning` INT NOT NULL AUTO_INCREMENT,
  `date_debut` DATETIME NULL,
  `date_fin` DATETIME NULL,
  `prestataire_id_prestataire` INT(11) NOT NULL,
  `prestataire_categorie_ville` VARCHAR(45) NOT NULL,
  `prestataire_categorie_nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_planning`, `prestataire_id_prestataire`, `prestataire_categorie_ville`, `prestataire_categorie_nom`),
  INDEX `fk_planning_prestataire1_idx` (`prestataire_id_prestataire` ASC, `prestataire_categorie_ville` ASC, `prestataire_categorie_nom` ASC) ,
  CONSTRAINT `fk_planning_prestataire1`
    FOREIGN KEY (`prestataire_id_prestataire` , `prestataire_categorie_ville` , `prestataire_categorie_nom`)
    REFERENCES `db_lille`.`prestataire` (`id_prestataire` , `categorie_ville` , `categorie_nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
