-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.5.50 - MySQL Community Server (GPL)
-- ОС Сервера:                   Win32
-- HeidiSQL Версия:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры базы данных sfts_courses
DROP DATABASE IF EXISTS `sfts_courses`;
CREATE DATABASE IF NOT EXISTS `sfts_courses` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sfts_courses`;


CREATE TABLE agCourses
(
  id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ShortName VARCHAR(100),
  Name VARCHAR(200) NOT NULL,
  googleDocID VARCHAR(50) NOT NULL,
  TOCJSON VARCHAR(20000) DEFAULT '' NOT NULL
);
CREATE TABLE agPupils
(
  id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  fName VARCHAR(100) NOT NULL,
  lName VARCHAR(100) NOT NULL,
  pwd1 VARCHAR(100) NOT NULL,
  pwd2 VARCHAR(100) NOT NULL,
  courseID INT(11) NOT NULL,
  login VARCHAR(100) NOT NULL
);
CREATE UNIQUE INDEX agPupils_id_uindex ON agpupils (id);
CREATE UNIQUE INDEX agPupils_login_uindex ON agpupils (login);