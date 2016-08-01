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


-- Дамп структуры для таблица sfts_courses.agcourses
DROP TABLE IF EXISTS `agcourses`;
CREATE TABLE IF NOT EXISTS `agcourses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(100) DEFAULT NULL,
  `Name` varchar(200) NOT NULL,
  `googleDocID` varchar(50) NOT NULL,
  `TOCJSON` varchar(20000) NOT NULL DEFAULT '',
  `Code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agCourses_Code_uindex` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agcourses: ~1 rows (приблизительно)
DELETE FROM `agcourses`;
/*!40000 ALTER TABLE `agcourses` DISABLE KEYS */;
INSERT INTO `agcourses` (`id`, `ShortName`, `Name`, `googleDocID`, `TOCJSON`, `Code`) VALUES
	(1, 'ПТМ руководителей культуры', 'ПРОГРАММА ОБУЧЕНИЯ ПОЖАРНО-ТЕХНИЧЕСКОГО МИНИМУМА ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ  ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)', '1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw', '[{"text":"1. Законодательная база в области пожарной безопасности","indentStart":18,"indentFirstLine":18,"linkUrl":"#heading=h.q50xcdyevsl5"},{"text":"1.1. Федеральные законы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.1nyf8737emu2"},{"text":"1.2. Ответственность арендаторов по пожарной безопасности","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.m5e0wz3w5zz4"},{"text":"1.3.Расчет и независимая оценка пожарного риска","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.bhcv33666er6"},{"text":"1.4. Другие нормативные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.g8507c64r9ht"},{"text":"1.5. Работы и услуги в области пожарной безопасности","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.nmdhp974mfae"},{"text":"3. Порядок проведения мероприятий по надзору","indentStart":18,"indentFirstLine":18,"linkUrl":"#heading=h.p66q3gyqyksa"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.nyti6xpri806"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.m43ii0fdkcp6"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.qmub3psbsd05"}]', '');
/*!40000 ALTER TABLE `agcourses` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.agpplgroups
DROP TABLE IF EXISTS `agpplgroups`;
CREATE TABLE IF NOT EXISTS `agpplgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(10) NOT NULL,
  `Name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agpplgroups_Code_uindex` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agpplgroups: ~0 rows (приблизительно)
DELETE FROM `agpplgroups`;
/*!40000 ALTER TABLE `agpplgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `agpplgroups` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.agpupils
DROP TABLE IF EXISTS `agpupils`;
CREATE TABLE IF NOT EXISTS `agpupils` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fName` varchar(100) NOT NULL,
  `lName` varchar(100) NOT NULL,
  `pwd1` varchar(100) DEFAULT NULL,
  `pwd2` varchar(100) DEFAULT NULL,
  `courseID` int(11) DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `testID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agPupils_id_uindex` (`id`),
  UNIQUE KEY `agPupils_login_uindex` (`login`),
  KEY `agpupils_agCourses_id_fk` (`courseID`),
  KEY `agpupils_agtests_id_fk` (`testID`),
  KEY `agpupils_login_pwd1_index` (`login`,`pwd1`),
  CONSTRAINT `agpupils_agCourses_id_fk` FOREIGN KEY (`courseID`) REFERENCES `agCourses` (`id`),
  CONSTRAINT `agpupils_agtests_id_fk` FOREIGN KEY (`testID`) REFERENCES `agtests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agpupils: ~4 rows (приблизительно)
DELETE FROM `agpupils`;
/*!40000 ALTER TABLE `agpupils` DISABLE KEYS */;
INSERT INTO `agpupils` (`id`, `fName`, `lName`, `pwd1`, `pwd2`, `courseID`, `login`, `testID`) VALUES
	(1, 'Алексей', 'Горбунов', '111111', NULL, 1, '100001', NULL),
	(2, 'Сергей', 'Иванов', '548547', NULL, NULL, '100002', NULL),
	(3, 'Иван', 'Сергеев', '935586', NULL, NULL, '100003', NULL),
	(4, 'Маша', 'Суралмаша', '999303', NULL, NULL, '100004', NULL);
/*!40000 ALTER TABLE `agpupils` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.agtests
DROP TABLE IF EXISTS `agtests`;
CREATE TABLE IF NOT EXISTS `agtests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(100) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Code` varchar(10) NOT NULL,
  `GoogleSheetID` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agTests_Code_uindex` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agtests: ~0 rows (приблизительно)
DELETE FROM `agtests`;
/*!40000 ALTER TABLE `agtests` DISABLE KEYS */;
/*!40000 ALTER TABLE `agtests` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
