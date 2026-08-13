-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tera_library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tera_library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tera_library` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `tera_library` ;

-- -----------------------------------------------------
-- Table `tera_library`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE INDEX `idx_author_name` (`author_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`publishers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`publishers` (
  `publisher_id` INT NOT NULL AUTO_INCREMENT,
  `publisher_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`publisher_id`),
  UNIQUE INDEX `idx_publisher_name` (`publisher_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`series` (
  `series_id` INT NOT NULL AUTO_INCREMENT,
  `series_name` VARCHAR(255) NOT NULL,
  `total_books` INT NULL DEFAULT NULL,
  PRIMARY KEY (`series_id`),
  UNIQUE INDEX `idx_series_name` (`series_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`books` (
  `isbn` VARCHAR(13) NOT NULL,
  `title` VARCHAR(500) NOT NULL,
  `book_type` ENUM('hardback', 'paperback') NOT NULL,
  `publisher_id` INT NOT NULL,
  `publication_year` YEAR NULL DEFAULT NULL,
  `series_id` INT NULL DEFAULT NULL,
  `series_number` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `bookshelf_number` INT NULL DEFAULT NULL,
  `shelf_number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`isbn`),
  INDEX `publisher_id` (`publisher_id` ASC) VISIBLE,
  INDEX `idx_title` (`title` ASC) VISIBLE,
  INDEX `series_id` (`series_id` ASC) VISIBLE,
  CONSTRAINT `books_ibfk_3`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `tera_library`.`publishers` (`publisher_id`),
  CONSTRAINT `books_ibfk_4`
    FOREIGN KEY (`series_id`)
    REFERENCES `tera_library`.`series` (`series_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`book_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`book_authors` (
  `book_isbn` VARCHAR(13) NOT NULL,
  `author_id` INT NOT NULL,
  `author_order` INT NULL DEFAULT NULL,
  PRIMARY KEY (`book_isbn`, `author_id`),
  INDEX `author_id` (`author_id` ASC) VISIBLE,
  CONSTRAINT `book_authors_ibfk_1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `tera_library`.`books` (`isbn`)
    ON DELETE CASCADE,
  CONSTRAINT `book_authors_ibfk_2`
    FOREIGN KEY (`author_id`)
    REFERENCES `tera_library`.`authors` (`author_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`genres` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE INDEX `idx_genre_name` (`genre_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 76
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`book_genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`book_genres` (
  `book_isbn` VARCHAR(13) NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`book_isbn`, `genre_id`),
  INDEX `genre_id` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `book_genres_ibfk_1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `tera_library`.`books` (`isbn`)
    ON DELETE CASCADE,
  CONSTRAINT `book_genres_ibfk_2`
    FOREIGN KEY (`genre_id`)
    REFERENCES `tera_library`.`genres` (`genre_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`loans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`loans` (
  `loan_id` INT NOT NULL AUTO_INCREMENT,
  `book_isbn` VARCHAR(13) NOT NULL,
  `borrower_name` VARCHAR(255) NOT NULL,
  `date_lent` DATE NOT NULL,
  `date_returned` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  INDEX `book_isbn` (`book_isbn` ASC) VISIBLE,
  CONSTRAINT `loans_ibfk_1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `tera_library`.`books` (`isbn`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tera_library`.`reading_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tera_library`.`reading_log` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `book_isbn` VARCHAR(13) NOT NULL,
  `date_started` DATE NULL DEFAULT NULL,
  `date_finished` DATE NULL DEFAULT NULL,
  `rating` TINYINT NULL DEFAULT NULL,
  `notes` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  INDEX `book_isbn` (`book_isbn` ASC) VISIBLE,
  CONSTRAINT `reading_log_ibfk_1`
    FOREIGN KEY (`book_isbn`)
    REFERENCES `tera_library`.`books` (`isbn`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
