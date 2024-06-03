-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema recipe
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema recipe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `recipe` DEFAULT CHARACTER SET utf8 ;
USE `recipe` ;

-- -----------------------------------------------------
-- Table `recipe`.`RECIPE_CLASS_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`RECIPE_CLASS_INFO` (
  `CLASS_ID` VARCHAR(10) NOT NULL COMMENT '레시피분류번호( 규칙 : C001 )',
  `CLASS_NAME` VARCHAR(50) NOT NULL COMMENT '레시피분류명',
  PRIMARY KEY (`CLASS_ID`)) COMMENT '레시피분류'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`USER_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`USER_INFO` (
  `USER_ID` VARCHAR(10) NOT NULL COMMENT '사용자번호(  규칙 : U001 ) ',
  `USER_NAME` VARCHAR(50) NOT NULL COMMENT '사용자이름',
  `USER_EMAIL` VARCHAR(50) NOT NULL COMMENT '이메일',
  `USER_PW` VARCHAR(30) NOT NULL COMMENT '비밀번호',
  `USER_ROLE` CHAR(1) NOT NULL DEFAULT 'G' COMMENT '사용자역할  ( G: 일반사용자   A: 관리자 )',
  `USER_DATE` DATETIME NOT NULL COMMENT '생성날짜',
  PRIMARY KEY (`USER_ID`)) COMMENT '회원'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`RECIPE_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`RECIPE_INFO` (
  `RECIPE_ID` VARCHAR(10) NOT NULL COMMENT '레시피번호( 규칙 : RE001 )',
  `CLASS_ID` VARCHAR(10) NOT NULL COMMENT '레시피분류번호( 규칙 : C001 )',
  `RECIPE_TITLE` VARCHAR(100) NOT NULL COMMENT '레시피명',
  `RECIPE_CONTENT` VARCHAR(4000) NULL COMMENT '레시피설명',
  `RECIPE_STUFF` VARCHAR(4000) NULL COMMENT '레시피재료',
  `RECIPE_SHOW` CHAR(1) NULL COMMENT '노출여부 (Y/N)',
  `RECIPE_GOOD` INT NULL COMMENT '레시피좋아요',
  `RECIPE_RCM` INT NULL COMMENT '레시피추천수',
  `RECIPE_CNT` INT NULL COMMENT '레시피조회수',
  `RECIPE_LEVEL` CHAR(1) NULL COMMENT '레시피난이도 (상/중/하)',
  `USER_ID` VARCHAR(10) NOT NULL COMMENT '사용자번호(  규칙 : U001 ) ',
  `RECIPE_DATE` DATETIME NOT NULL COMMENT '생성날짜',
  PRIMARY KEY (`RECIPE_ID`),
  INDEX `fk_RECIPE_INFO_RECIPE_CLASS_INFO_idx` (`CLASS_ID` ASC) VISIBLE,
  INDEX `fk_RECIPE_INFO_USER_INFO1_idx` (`USER_ID` ASC) VISIBLE,
  CONSTRAINT `fk_RECIPE_INFO_RECIPE_CLASS_INFO`
    FOREIGN KEY (`CLASS_ID`)
    REFERENCES `recipe`.`RECIPE_CLASS_INFO` (`CLASS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECIPE_INFO_USER_INFO1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `recipe`.`USER_INFO` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) COMMENT '레시피'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`RECIPE_REPLY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`RECIPE_REPLY` (
  `RECIPE_ID` VARCHAR(10) NOT NULL COMMENT '레시피번호( 규칙 : RE001 )',
  `COMMENT_ID` VARCHAR(50) NOT NULL COMMENT '댓글번호( 규칙 : CM001 )',
  `COMMENT_CONTENT` VARCHAR(30) NULL COMMENT '댓글내용',
  `USER_ID` VARCHAR(10) NOT NULL COMMENT '사용자번호(  규칙 : U001 ) ',
  `COMMENT_DATE` DATETIME NOT NULL COMMENT '생성날짜',
  INDEX `fk_RECIPE_REPLY_RECIPE_INFO1_idx` (`RECIPE_ID` ASC) VISIBLE,
  PRIMARY KEY (`RECIPE_ID`),
  INDEX `fk_RECIPE_REPLY_USER_INFO1_idx` (`USER_ID` ASC) VISIBLE,
  CONSTRAINT `fk_RECIPE_REPLY_RECIPE_INFO1`
    FOREIGN KEY (`RECIPE_ID`)
    REFERENCES `recipe`.`RECIPE_INFO` (`RECIPE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECIPE_REPLY_USER_INFO1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `recipe`.`USER_INFO` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) COMMENT '레시피댓글'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`RECIPE_IMAGE_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`RECIPE_IMAGE_INFO` (
  `RECIPE_ID` VARCHAR(10) NOT NULL COMMENT '레시피번호( 규칙 : RE001 )',
  `IMG_PATH_01` VARCHAR(200) NULL COMMENT '이미지01path',
  `IMG_PATH_02` VARCHAR(200) NULL COMMENT '이미지02path',
  `IMG_PATH_03` VARCHAR(200) NULL COMMENT '이미지03path',
  `IMG_MAIN` VARCHAR(10) NULL COMMENT '대표사진  ( PATH01/PATH02/ PATH03 )',
  INDEX `fk_RECIPE_IMAGE_INFO_RECIPE_INFO1_idx` (`RECIPE_ID` ASC) VISIBLE,
  PRIMARY KEY (`RECIPE_ID`),
  CONSTRAINT `fk_RECIPE_IMAGE_INFO_RECIPE_INFO1`
    FOREIGN KEY (`RECIPE_ID`)
    REFERENCES `recipe`.`RECIPE_INFO` (`RECIPE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) COMMENT '레시피사진'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`ASK_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`ASK_INFO` (
  `ASK_ID` VARCHAR(10) NOT NULL COMMENT '문의사항번호( 규칙 : A001 )',
  `ASK_TITLE` VARCHAR(100) NULL COMMENT '문의제목',
  `ASK_CONTENT` VARCHAR(4000) NULL COMMENT '문의내용',
  `USER_ID` VARCHAR(10) NOT NULL COMMENT '사용자번호(  규칙 : U001 ) ',
  `ASK_DATE` DATETIME NULL COMMENT '생성날짜',
  `ASK_UPDATE` DATETIME NULL COMMENT '수정날짜',
  PRIMARY KEY (`ASK_ID`),
  INDEX `fk_ASK_INFO_USER_INFO1_idx` (`USER_ID` ASC) VISIBLE,
  CONSTRAINT `fk_ASK_INFO_USER_INFO1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `recipe`.`USER_INFO` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) COMMENT '문의사항'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`ASK_REPLY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`ASK_REPLY` (
  `ASK_ID` VARCHAR(10) NOT NULL COMMENT '문의사항번호( 규칙 : A001 )',
  `RECOMM_ID` VARCHAR(10) NULL COMMENT '문의사항댓글번호 ( 규칙 : RM001 ) ',
  `RECOMM_CONTENT` VARCHAR(4000) NULL COMMENT '문의댓글내용',
  `USER_ID` VARCHAR(10) NOT NULL COMMENT '사용자번호(  규칙 : U001 ) ',
  `RECOMM_DATE` DATETIME NULL COMMENT '생성날짜',
  INDEX `fk_ASK_REPLY_ASK_INFO1_idx` (`ASK_ID` ASC) VISIBLE,
  PRIMARY KEY (`ASK_ID`),
  INDEX `fk_ASK_REPLY_USER_INFO1_idx` (`USER_ID` ASC) VISIBLE,
  CONSTRAINT `fk_ASK_REPLY_ASK_INFO1`
    FOREIGN KEY (`ASK_ID`)
    REFERENCES `recipe`.`ASK_INFO` (`ASK_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASK_REPLY_USER_INFO1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `recipe`.`USER_INFO` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) COMMENT '문의사항댓글'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`CATEGORY_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`CATEGORY_INFO` (
  `CATE_ID` VARCHAR(10) NOT NULL COMMENT '카테고리번호( 규칙 : CG001 ) ',
  `CATE_NAME` VARCHAR(100) NOT NULL COMMENT '카테고리명',
  `CATE_ORDER` VARCHAR(10) NOT NULL COMMENT '카테고리순서',
  `CATE_PLACE` CHAR(2) NOT NULL COMMENT '카테고리위치 ( F: front   B:back   FB:both )',
  `CATE_DATE` DATETIME NOT NULL COMMENT '생성날짜',
  PRIMARY KEY (`CATE_ID`)) COMMENT '카테고리'
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`.`NOTICE_INFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe`.`NOTICE_INFO` (
  `NOTICE_ID` VARCHAR(10) NOT NULL COMMENT '공지사항번호 ( 규칙 : N001 ) ',
  `NOTICE_TITLE` VARCHAR(100) NULL COMMENT '공지사항제목',
  `NOTICE_CONTENT` VARCHAR(10) NULL COMMENT '공지사항내용',
  `USER_ID` VARCHAR(10) NOT NULL COMMENT '사용자번호 ( 규칙 : U001 ) ',
  `NOTICE_DATE` DATETIME NULL COMMENT '생성날짜',
  `NOTICE_UPDATE` DATETIME NULL COMMENT '수정날짜',
  PRIMARY KEY (`NOTICE_ID`),
  INDEX `fk_NOTICE_INFO_USER_INFO1_idx` (`USER_ID` ASC) VISIBLE,
  CONSTRAINT `fk_NOTICE_INFO_USER_INFO1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `recipe`.`USER_INFO` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) COMMENT '공지사항'
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
