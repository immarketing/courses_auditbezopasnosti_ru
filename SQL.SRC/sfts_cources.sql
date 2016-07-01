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


-- Дамп структуры для таблица sfts_courses.agCourses
DROP TABLE IF EXISTS `agCourses`;
CREATE TABLE IF NOT EXISTS `agCourses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ShortName` text,
  `Name` text NOT NULL,
  `googleDocID` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agCourses: ~1 rows (приблизительно)
DELETE FROM `agCourses`;
/*!40000 ALTER TABLE `agCourses` DISABLE KEYS */;
INSERT INTO `agCourses` (`id`, `ShortName`, `Name`, `googleDocID`) VALUES
	(1, 'ПТМ руководителей культуры', 'ПРОГРАММА ОБУЧЕНИЯ ПОЖАРНО-ТЕХНИЧЕСКОГО МИНИМУМА ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ  ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)', '1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw');
/*!40000 ALTER TABLE `agCourses` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
