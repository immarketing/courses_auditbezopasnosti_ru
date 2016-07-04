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
  `ShortName` varchar(100) DEFAULT NULL,
  `Name` varchar(200) NOT NULL,
  `googleDocID` varchar(50) NOT NULL,
  `TOCJSON` varchar(20000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agCourses: ~1 rows (приблизительно)
DELETE FROM `agCourses`;
/*!40000 ALTER TABLE `agCourses` DISABLE KEYS */;
INSERT INTO `agCourses` (`id`, `ShortName`, `Name`, `googleDocID`, `TOCJSON`) VALUES
	(1, 'ПТМ руководителей культуры', 'ПРОГРАММА ОБУЧЕНИЯ ПОЖАРНО-ТЕХНИЧЕСКОГО МИНИМУМА ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ  ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)', '1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw', '[{"text":"1. Законодательная база в области пожарной безопасности","indentStart":18,"indentFirstLine":18,"linkUrl":"#heading=h.q50xcdyevsl5"},{"text":"1.1. Федеральные законы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.1nyf8737emu2"},{"text":"1.2. Ответственность арендаторов по пожарной безопасности","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.m5e0wz3w5zz4"},{"text":"1.3.Расчет и независимая оценка пожарного риска","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.bhcv33666er6"},{"text":"1.4. Другие нормативные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.g8507c64r9ht"},{"text":"1.5. Работы и услуги в области пожарной безопасности","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.nmdhp974mfae"},{"text":"3. Порядок проведения мероприятий по надзору","indentStart":18,"indentFirstLine":18,"linkUrl":"#heading=h.p66q3gyqyksa"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.nyti6xpri806"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.m43ii0fdkcp6"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.qmub3psbsd05"}]');
/*!40000 ALTER TABLE `agCourses` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
