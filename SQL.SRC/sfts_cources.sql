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
	(1, 'ПТМ руководителей культуры', 'ПРОГРАММА ОБУЧЕНИЯ ПОЖАРНО-ТЕХНИЧЕСКОГО МИНИМУМА ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ  ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)', '1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw', '[{"text":"1. Законодательная база в области пожарной безопасности","indentStart":18,"indentFirstLine":18,"linkUrl":"#heading=h.q50xcdyevsl5"},{"text":"1.1. Федеральные законы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.1nyf8737emu2"},{"text":"1.2. Ответственность арендаторов по пожарной безопасности","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.m5e0wz3w5zz4"},{"text":"1.3.Расчет и независимая оценка пожарного риска","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.bhcv33666er6"},{"text":"1.4. Другие нормативные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.g8507c64r9ht"},{"text":"1.5. Работы и услуги в области пожарной безопасности","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.nmdhp974mfae"},{"text":"3. Порядок проведения мероприятий по надзору","indentStart":18,"indentFirstLine":18,"linkUrl":"#heading=h.p66q3gyqyksa"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.nyti6xpri806"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.m43ii0fdkcp6"},{"text":"3.1. Нормативные акты, ведомственные документы","indentStart":36,"indentFirstLine":36,"linkUrl":"#heading=h.qmub3psbsd05"}]', 'ПТМ.РК');
/*!40000 ALTER TABLE `agcourses` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.agpplgroups
DROP TABLE IF EXISTS `agpplgroups`;
CREATE TABLE IF NOT EXISTS `agpplgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(10) NOT NULL,
  `Name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agpplgroups_Code_uindex` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agpplgroups: ~5 rows (приблизительно)
DELETE FROM `agpplgroups`;
/*!40000 ALTER TABLE `agpplgroups` DISABLE KEYS */;
INSERT INTO `agpplgroups` (`id`, `Code`, `Name`) VALUES
	(1, 'qq', 'qqqqqq'),
	(2, 'ww', 'wwwwww'),
	(5, 'asf', 'sadf'),
	(6, 'Код', 'Два'),
	(7, 'g', 'g');
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
  `testResult` mediumtext,
  `isTestCompleted` tinyint(1) NOT NULL DEFAULT '0',
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
INSERT INTO `agpupils` (`id`, `fName`, `lName`, `pwd1`, `pwd2`, `courseID`, `login`, `testID`, `testResult`, `isTestCompleted`) VALUES
	(1, 'Алексей', 'Горбунов', '111111', NULL, 1, '100001', 1, '{"qCount":12,"corrCount":1,"resPercent":8.3333333333333,"aData":{"b113b166-c4b0-4117-8113-69fefcd35258":"1","b346f89c-4311-4346-8299-dbf8c48b59a5":"4","91f3c142-be82-488c-9fed-16fbd89ed3c6":"2","fdb98a43-5a37-4ca5-a864-bac079d17b9e":"6","8c16e8ce-b8a8-40a6-bebc-97b207593f38":"5","c137e133-5b83-4dec-942e-2b0bf60f32b2":"3"},"qData":{"b113b166-c4b0-4117-8113-69fefcd35258":1,"b346f89c-4311-4346-8299-dbf8c48b59a5":"","91f3c142-be82-488c-9fed-16fbd89ed3c6":"","fdb98a43-5a37-4ca5-a864-bac079d17b9e":"","8c16e8ce-b8a8-40a6-bebc-97b207593f38":"","c137e133-5b83-4dec-942e-2b0bf60f32b2":"","f76ff71a-041b-4416-9b07-bd68f88d36c5":"","7cbb8c73-5e55-4113-a010-bc240141e813":"","554e8335-f536-48bf-9718-8650d6becb7a":"","fa782a5a-6126-4d09-af3c-78627f358a76":"","1f9ea0eb-d53b-47ed-9358-a5157b4a398a":"","bc031d41-7961-47de-95ca-9dd669247c25":""}}', 1),
	(2, 'Сергей', 'Иванов', '548547', NULL, NULL, '100002', NULL, NULL, 0),
	(3, 'Иван', 'Сергеев', '935586', NULL, NULL, '100003', NULL, NULL, 0),
	(4, 'Маша', 'Суралмаша', '999303', NULL, NULL, '100004', NULL, NULL, 0);
/*!40000 ALTER TABLE `agpupils` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.agtests
DROP TABLE IF EXISTS `agtests`;
CREATE TABLE IF NOT EXISTS `agtests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ShortName` varchar(100) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Code` varchar(10) NOT NULL,
  `GoogleSheetID` varchar(50) NOT NULL,
  `JSON` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agTests_Code_uindex` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.agtests: ~1 rows (приблизительно)
DELETE FROM `agtests`;
/*!40000 ALTER TABLE `agtests` DISABLE KEYS */;
INSERT INTO `agtests` (`id`, `ShortName`, `Name`, `Code`, `GoogleSheetID`, `JSON`) VALUES
	(1, 'Тест ПТМ.РК.1', 'Тест ПТМ.РК.1', 'ПТМ.РК.1', '1wguJxZMOM9gxCl_IxXg6EetORwIEzG-qWHDbHltiiIw', '{"Description":{"LongName":"Тест на знание всех знаний","ShortName":"Тест 1","RightPercent":70},"data":[{"qNo":1,"qText":"Таким образом начало повседневной работы по формированию позиции позволяет выполнять важные задания по разработке систем массового участия. Идейные соображения высшего порядка, а также постоянный количественный рост и сфера нашей активности влечет за собой процесс внедрения и модернизации соответствующий условий активизации.","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":1,"UID":"b113b166-c4b0-4117-8113-69fefcd35258"},{"qNo":2,"qText":"С другой стороны сложившаяся структура организации позволяет оценить значение форм развития. Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности требуют от нас анализа систем массового участия. Равным образом постоянное информационно-пропагандистское обеспечение нашей деятельности представляет собой интересный эксперимент проверки модели развития. Повседневная практика показывает, что начало повседневной работы по формированию позиции в значительной степени обуславливает создание соответствующий условий активизации.","qAns1":"Ответ 1","qAns2":"Ответ 2","qAns3":"Ответ 3","qAns4":"Ответ 4","qAns5":"Ответ 5","qAns6":"Ответ 6","qAnsCorr":"","UID":"b346f89c-4311-4346-8299-dbf8c48b59a5"},{"qNo":3,"qText":"Значимость этих проблем настолько очевидна, что реализация намеченных плановых заданий в значительной степени обуславливает создание модели развития. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности обеспечивает широкому кругу (специалистов) участие в формировании дальнейших направлений развития. Товарищи! рамки и место обучения кадров требуют определения и уточнения дальнейших направлений развития. Не следует, однако забывать, что постоянный количественный рост и сфера нашей активности обеспечивает широкому кругу (специалистов) участие в формировании форм развития. Идейные соображения высшего порядка, а также укрепление и развитие структуры играет важную роль в формировании систем массового участия.","qAns1":"Ответ 1","qAns2":"Ответ 2","qAns3":"Ответ 3","qAns4":"Ответ 4","qAns5":"Ответ 5","qAns6":"Ответ 6","qAnsCorr":"","UID":"91f3c142-be82-488c-9fed-16fbd89ed3c6"},{"qNo":4,"qText":"Идейные соображения высшего порядка, а также укрепление и развитие структуры требуют от нас анализа системы обучения кадров, соответствует насущным потребностям. Повседневная практика показывает, что начало повседневной работы по формированию позиции представляет собой интересный эксперимент проверки систем массового участия.","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"fdb98a43-5a37-4ca5-a864-bac079d17b9e"},{"qNo":5,"qText":"Равным образом сложившаяся структура организации способствует подготовки и реализации соответствующий условий активизации. Равным образом консультация с широким активом играет важную роль в формировании модели развития. Идейные соображения высшего порядка, а также начало повседневной работы по формированию позиции способствует подготовки и реализации системы обучения кадров, соответствует насущным потребностям. Повседневная практика показывает, что рамки и место обучения кадров представляет собой интересный эксперимент проверки дальнейших направлений развития. Повседневная практика показывает, что реализация намеченных плановых заданий представляет собой интересный эксперимент проверки позиций, занимаемых участниками в отношении поставленных задач.","qAns1":"Ответ 1","qAns2":"Ответ 2","qAns3":"Ответ 3","qAns4":"Ответ 4","qAns5":"Ответ 5","qAns6":"Ответ 6","qAnsCorr":"","UID":"8c16e8ce-b8a8-40a6-bebc-97b207593f38"},{"qNo":6,"qText":"С другой стороны постоянный количественный рост и сфера нашей активности позволяет оценить значение новых предложений. Разнообразный и богатый опыт рамки и место обучения кадров позволяет выполнять важные задания по разработке позиций, занимаемых участниками в отношении поставленных задач. Повседневная практика показывает, что постоянное информационно-пропагандистское обеспечение нашей деятельности обеспечивает широкому кругу (специалистов) участие в формировании направлений прогрессивного развития. Идейные соображения высшего порядка, а также сложившаяся структура организации требуют определения и уточнения новых предложений. С другой стороны постоянное информационно-пропагандистское обеспечение нашей деятельности требуют от нас анализа позиций, занимаемых участниками в отношении поставленных задач.","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"c137e133-5b83-4dec-942e-2b0bf60f32b2"},{"qNo":7,"qText":"Таким образом новая модель организационной деятельности требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. С другой стороны реализация намеченных плановых заданий представляет собой интересный эксперимент проверки форм развития.","qAns1":"Ответ 1","qAns2":"Ответ 2","qAns3":"Ответ 3","qAns4":"Ответ 4","qAns5":"Ответ 5","qAns6":"Ответ 6","qAnsCorr":"","UID":"f76ff71a-041b-4416-9b07-bd68f88d36c5"},{"qNo":8,"qText":"Таким образом постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке позиций, занимаемых участниками в отношении поставленных задач. С другой стороны дальнейшее развитие различных форм деятельности играет важную роль в формировании существенных финансовых и административных условий. Значимость этих проблем настолько очевидна, что дальнейшее развитие различных форм деятельности играет важную роль в формировании модели развития. Не следует, однако забывать, что постоянный количественный рост и сфера нашей активности позволяет выполнять важные задания по разработке позиций, занимаемых участниками в отношении поставленных задач.","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"7cbb8c73-5e55-4113-a010-bc240141e813"},{"qNo":9,"qText":"Повседневная практика показывает, что рамки и место обучения кадров требуют определения и уточнения позиций, занимаемых участниками в отношении поставленных задач. Значимость этих проблем настолько очевидна, что укрепление и развитие структуры представляет собой интересный эксперимент проверки дальнейших направлений развития.","qAns1":"Ответ 1","qAns2":"Ответ 2","qAns3":"Ответ 3","qAns4":"Ответ 4","qAns5":"Ответ 5","qAns6":"Ответ 6","qAnsCorr":"","UID":"554e8335-f536-48bf-9718-8650d6becb7a"},{"qNo":10,"qText":"Товарищи! начало повседневной работы по формированию позиции позволяет выполнять важные задания по разработке новых предложений. Задача организации, в особенности же постоянный количественный рост и сфера нашей активности играет важную роль в формировании новых предложений.","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"fa782a5a-6126-4d09-af3c-78627f358a76"},{"qNo":11,"qText":"Таким образом укрепление и развитие структуры позволяет выполнять важные задания по разработке системы обучения кадров, соответствует насущным потребностям. Таким образом реализация намеченных плановых заданий представляет собой интересный эксперимент проверки форм развития.","qAns1":"Ответ 1","qAns2":"Ответ 2","qAns3":"Ответ 3","qAns4":"Ответ 4","qAns5":"Ответ 5","qAns6":"Ответ 6","qAnsCorr":"","UID":"1f9ea0eb-d53b-47ed-9358-a5157b4a398a"},{"qNo":12,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"69e51de7-86a9-4b13-98fa-221215111db8"},{"qNo":13,"qText":"Тринадцатый, мать перемать","qAns1":"Ответ 1","qAns2":"Ответ 2","qAns3":"Ответ 3","qAns4":"Ответ 4","qAns5":"Ответ 5","qAns6":"Ответ 6","qAnsCorr":"","UID":"bc031d41-7961-47de-95ca-9dd669247c25"},{"qNo":14,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"86cbe81d-2085-4d25-a4bc-dcbadc573cea"},{"qNo":15,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"5b54cf09-00fa-4af3-be38-31456201b4f6"},{"qNo":16,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"b4877ac3-382e-43da-a01c-568b898296ee"},{"qNo":17,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"4ad0f90f-0658-4889-8de0-ac14f8531a15"},{"qNo":18,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"954045c3-19cd-4e5b-a64e-96a45276199d"},{"qNo":19,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"658ebd6c-9edd-40d3-bb64-560f97891126"},{"qNo":20,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"e1e35094-a3e3-43c2-9543-83e0c2a34b14"},{"qNo":21,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"e9e709c1-33d1-4ffc-98fb-ceb792350e5a"},{"qNo":22,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"47f08464-88b5-4726-bf2d-810c57833315"},{"qNo":23,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"fdd51fce-50d1-4878-b4bc-2b73ece34e41"},{"qNo":24,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"8f7127e8-e54c-494e-bbb6-18fcf088684a"},{"qNo":25,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"6675cb5d-33bb-4214-8590-034e7486ee51"},{"qNo":26,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"55bb687c-3daa-41b3-a09a-cce1bdea9d67"},{"qNo":27,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"83f33d7f-d333-4aec-8a1f-b6528f5cf099"},{"qNo":28,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"60066e82-f15d-46bf-bbc1-4d1474f6b120"},{"qNo":29,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"9558370d-5693-4e91-8b11-af4bca462788"},{"qNo":30,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"5c502e23-ec5b-4068-960c-e70265962eb4"},{"qNo":31,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"e7dcda9f-af5a-459e-98a2-7ff6b0c31f3f"},{"qNo":32,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"7d327031-1d91-41d2-93ca-035b625836aa"},{"qNo":33,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"55aa0d8d-a45b-40f2-9ac5-8c21b5ed9dcd"},{"qNo":34,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"f6e3b3c0-eedb-4156-9313-a7a4e175c5d8"},{"qNo":35,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"625a79e6-f183-4333-9b61-b5fb06411458"},{"qNo":36,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"42f4ec1e-f87e-4ea1-b3d4-5a24cf2363ba"},{"qNo":37,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"9505cc60-c22b-459a-9d32-6aa9e007b865"},{"qNo":38,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"d4e17fe7-8dc9-42df-bedd-aca77a95b563"},{"qNo":39,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"02e21f98-0a49-48c4-9176-42e985c51f28"},{"qNo":40,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"a690c5ce-2821-48bf-ad01-8ed3941d1613"},{"qNo":41,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"d2a01df1-99f8-4e05-b261-d9071a862f66"},{"qNo":42,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"76fa8466-bf89-422d-b026-1318faf4b560"},{"qNo":43,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"bf4232bd-c353-4490-baa7-a9b4ad2d0a69"},{"qNo":44,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"cc8e1d56-74a7-43f4-bdef-9b2f3fbe6b2a"},{"qNo":45,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"d7230d1d-8bdb-4ddb-b5a7-8bc46cbc9ce0"},{"qNo":46,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"b8283cc2-4394-4bce-af29-b87e7406e7f0"},{"qNo":47,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"98661433-fd8f-429f-b246-558d36b4cc06"},{"qNo":48,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"5971a7a9-6fde-4a9b-9c95-a779d29ba3ec"},{"qNo":49,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"9dcb917d-a81a-42f4-b1a8-014270dc2420"},{"qNo":50,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"f5870599-d854-4772-b451-25b1d2144443"},{"qNo":51,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"91735962-09db-4c3b-a280-4fae0a04d33e"},{"qNo":52,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"6011c210-972e-4ddc-8ab3-2013c27548fb"},{"qNo":53,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"d7109b6c-1e97-42eb-a3dc-265e916c3034"},{"qNo":54,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"2f1b0587-aaca-42bb-a56e-a154c13dc12e"},{"qNo":55,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"c8ed8ab8-45f1-4fc6-8d37-06e9cd87d178"},{"qNo":56,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"0648fdfc-d0f5-4380-9028-c9e42ae60cac"},{"qNo":57,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"24461b6a-df4b-4763-9c6d-c1f0a2ed6a13"},{"qNo":58,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"edf38e1c-b7f6-49d7-a1d8-f9d7444524ae"},{"qNo":59,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":"eb1a204a-bc69-4821-b707-34470a15072b"},{"qNo":60,"qText":"","qAns1":"","qAns2":"","qAns3":"","qAns4":"","qAns5":"","qAns6":"","qAnsCorr":"","UID":""}]}');
/*!40000 ALTER TABLE `agtests` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.bootgrid_data
DROP TABLE IF EXISTS `bootgrid_data`;
CREATE TABLE IF NOT EXISTS `bootgrid_data` (
  `id` int(11) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `salary` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы sfts_courses.bootgrid_data: ~173 rows (приблизительно)
DELETE FROM `bootgrid_data`;
/*!40000 ALTER TABLE `bootgrid_data` DISABLE KEYS */;
INSERT INTO `bootgrid_data` (`id`, `first_name`, `last_name`, `email`, `gender`, `country`, `salary`) VALUES
	(1, 'Rebecca', 'Henderson', 'rhenderson0@google.pl', 'Female', 'New Zealand', '$6751.01'),
	(2, 'Linda', 'Stone', 'lstone1@creativecommons.org', 'Female', 'Czech Republic', '$2819.45'),
	(3, 'Robert', 'Foster', 'rfoster2@constantcontact.com', 'Male', 'Peru', '$6731.95'),
	(4, 'Donna', 'Harrison', 'dharrison3@privacy.gov.au', 'Female', 'Azerbaijan', '$5516.94'),
	(5, 'Harry', 'Henry', 'hhenry4@yellowbook.com', 'Male', 'Ghana', '$8656.83'),
	(6, 'Jack', 'Stanley', 'jstanley5@ftc.gov', 'Male', 'China', '$5787.16'),
	(7, 'Cynthia', 'Tucker', 'ctucker6@cyberchimps.com', 'Female', 'Afghanistan', '$2472.73'),
	(8, 'Joe', 'Cox', 'jcox7@netlog.com', 'Male', 'Brazil', '$2450.87'),
	(9, 'Jerry', 'Kennedy', 'jkennedy8@prweb.com', 'Male', 'Egypt', '$5249.28'),
	(10, 'Jessica', 'Hughes', 'jhughes9@csmonitor.com', 'Female', 'New Zealand', '$7547.55'),
	(11, 'Jennifer', 'Wagner', 'jwagnera@phoca.cz', 'Female', 'Sweden', '$3832.17'),
	(12, 'Robin', 'Lopez', 'rlopezb@nsw.gov.au', 'Female', 'Japan', '$8550.79'),
	(13, 'Douglas', 'Garrett', 'dgarrettc@goodreads.com', 'Male', 'Poland', '$8571.53'),
	(14, 'Laura', 'Porter', 'lporterd@live.com', 'Female', 'Indonesia', '$3712.85'),
	(15, 'Sarah', 'Cole', 'scolee@smh.com.au', 'Female', 'Oman', '$9974.40'),
	(16, 'Steve', 'Perry', 'sperryf@tinypic.com', 'Male', 'Kazakhstan', '$1288.90'),
	(17, 'Sean', 'Powell', 'spowellg@indiegogo.com', 'Male', 'Guinea', '$9418.59'),
	(18, 'Timothy', 'Wagner', 'twagnerh@ask.com', 'Male', 'Bangladesh', '$2283.04'),
	(19, 'Lois', 'Carroll', 'lcarrolli@samsung.com', 'Female', 'Thailand', '$7846.98'),
	(20, 'Paula', 'Harvey', 'pharveyj@qq.com', 'Female', 'Paraguay', '$8531.18'),
	(21, 'Victor', 'Cox', 'vcoxk@cbsnews.com', 'Male', 'Portugal', '$2923.77'),
	(22, 'Ruby', 'Young', 'ryoungl@latimes.com', 'Female', 'China', '$3435.56'),
	(23, 'Theresa', 'Allen', 'tallenm@simplemachines.org', 'Female', 'Philippines', '$4366.83'),
	(24, 'Kelly', 'Lee', 'kleen@nhs.uk', 'Female', 'Serbia', '$7094.12'),
	(25, 'Betty', 'Ray', 'brayo@mashable.com', 'Female', 'Honduras', '$8206.63'),
	(26, 'Dennis', 'Peters', 'dpetersp@storify.com', 'Male', 'Brazil', '$6648.47'),
	(27, 'Bonnie', 'Ford', 'bfordq@un.org', 'Female', 'South Africa', '$3259.17'),
	(28, 'Brian', 'Lawrence', 'blawrencer@over-blog.com', 'Male', 'China', '$6851.37'),
	(29, 'Susan', 'Jackson', 'sjacksons@blogs.com', 'Female', 'Malta', '$3188.10'),
	(30, 'Kevin', 'Ward', 'kwardt@baidu.com', 'Male', 'Ireland', '$8966.99'),
	(31, 'Martin', 'Campbell', 'mcampbellu@washington.edu', 'Male', 'Canada', '$6297.08'),
	(32, 'Thomas', 'Stone', 'tstonev@baidu.com', 'Male', 'Indonesia', '$8116.39'),
	(33, 'Kelly', 'Perry', 'kperryw@newsvine.com', 'Female', 'China', '$7907.94'),
	(34, 'Linda', 'Powell', 'lpowellx@ebay.co.uk', 'Female', 'China', '$8035.02'),
	(35, 'Christopher', 'Butler', 'cbutlery@biblegateway.com', 'Male', 'China', '$7759.94'),
	(36, 'Janet', 'Dean', 'jdeanz@amazon.co.uk', 'Female', 'Egypt', '$1771.65'),
	(37, 'Ryan', 'Hill', 'rhill10@sciencedirect.com', 'Male', 'Croatia', '$3923.30'),
	(38, 'Matthew', 'Campbell', 'mcampbell11@sciencedaily.com', 'Male', 'Mongolia', '$1372.40'),
	(39, 'Lawrence', 'Ryan', 'lryan12@about.me', 'Male', 'Philippines', '$2140.14'),
	(40, 'Arthur', 'Stewart', 'astewart13@statcounter.com', 'Male', 'Mongolia', '$4186.78'),
	(41, 'Angela', 'Patterson', 'apatterson14@ebay.co.uk', 'Female', 'Indonesia', '$6152.54'),
	(42, 'Nancy', 'Wallace', 'nwallace15@eepurl.com', 'Female', 'France', '$4865.48'),
	(43, 'Jesse', 'Anderson', 'janderson16@archive.org', 'Male', 'Philippines', '$5383.53'),
	(44, 'Joseph', 'Chapman', 'jchapman17@mysql.com', 'Male', 'China', '$9397.94'),
	(45, 'Larry', 'Moreno', 'lmoreno18@unesco.org', 'Male', 'Indonesia', '$7000.48'),
	(46, 'Jonathan', 'Perry', 'jperry19@dailymail.co.uk', 'Male', 'Netherlands', '$3109.57'),
	(47, 'Christina', 'Wallace', 'cwallace1a@nytimes.com', 'Female', 'Serbia', '$6210.45'),
	(48, 'Deborah', 'Ford', 'dford1b@reddit.com', 'Female', 'Argentina', '$2724.54'),
	(49, 'Steven', 'Stewart', 'sstewart1c@barnesandnoble.com', 'Male', 'Sweden', '$8968.14'),
	(50, 'Mark', 'Gomez', 'mgomez1d@edublogs.org', 'Male', 'China', '$9469.81'),
	(51, 'Ralph', 'Morrison', 'rmorrison1e@nifty.com', 'Male', 'Ethiopia', '$8598.41'),
	(52, 'Cheryl', 'Garza', 'cgarza1f@cnn.com', 'Female', 'Colombia', '$7649.86'),
	(53, 'Martin', 'Bailey', 'mbailey1g@hud.gov', 'Male', 'Rwanda', '$3610.32'),
	(54, 'Robin', 'Hill', 'rhill1h@nifty.com', 'Female', 'Philippines', '$4474.71'),
	(55, 'Jack', 'Ward', 'jward1i@multiply.com', 'Male', 'Poland', '$1095.01'),
	(56, 'Anna', 'Ross', 'aross1j@mashable.com', 'Female', 'Sweden', '$5773.23'),
	(57, 'Ralph', 'Torres', 'rtorres1k@jalbum.net', 'Male', 'Czech Republic', '$3321.11'),
	(58, 'David', 'Watkins', 'dwatkins1l@histats.com', 'Male', 'China', '$2130.78'),
	(59, 'Stephen', 'Robertson', 'srobertson1m@jimdo.com', 'Male', 'Portugal', '$8547.36'),
	(60, 'Angela', 'Robertson', 'arobertson1n@rediff.com', 'Female', 'Argentina', '$6893.39'),
	(61, 'Doris', 'Richards', 'drichards1o@un.org', 'Female', 'China', '$5799.22'),
	(62, 'Gregory', 'Palmer', 'gpalmer1p@google.ca', 'Male', 'Philippines', '$2583.09'),
	(63, 'Willie', 'Smith', 'wsmith1q@soup.io', 'Male', 'Russia', '$2510.36'),
	(64, 'Adam', 'Graham', 'agraham1r@tuttocitta.it', 'Male', 'China', '$8782.44'),
	(65, 'Sandra', 'Watson', 'swatson1s@uol.com.br', 'Female', 'China', '$3698.47'),
	(66, 'Mildred', 'Powell', 'mpowell1t@blinklist.com', 'Female', 'Zimbabwe', '$4080.17'),
	(67, 'James', 'Larson', 'jlarson1u@alibaba.com', 'Male', 'United States', '$9393.89'),
	(68, 'Nancy', 'Jacobs', 'njacobs1v@apache.org', 'Female', 'Philippines', '$3650.96'),
	(69, 'Todd', 'Carpenter', 'tcarpenter1w@issuu.com', 'Male', 'Indonesia', '$5186.27'),
	(70, 'Sean', 'Woods', 'swoods1x@over-blog.com', 'Male', 'United States', '$4846.39'),
	(71, 'Jane', 'Garcia', 'jgarcia1y@prweb.com', 'Female', 'Indonesia', '$2818.95'),
	(72, 'Amanda', 'Coleman', 'acoleman1z@miitbeian.gov.cn', 'Female', 'Russia', '$6108.21'),
	(73, 'Gloria', 'Simpson', 'gsimpson20@infoseek.co.jp', 'Female', 'Nigeria', '$1235.23'),
	(74, 'Shirley', 'Thompson', 'sthompson21@ebay.co.uk', 'Female', 'China', '$5816.60'),
	(75, 'Jimmy', 'Perkins', 'jperkins22@paypal.com', 'Male', 'Russia', '$4799.27'),
	(76, 'Cheryl', 'Jacobs', 'cjacobs23@blogspot.com', 'Female', 'China', '$7528.64'),
	(77, 'Amy', 'Wright', 'awright24@bing.com', 'Female', 'Russia', '$1334.09'),
	(78, 'Steve', 'Campbell', 'scampbell25@mail.ru', 'Male', 'Sweden', '$6915.05'),
	(79, 'Sara', 'Rogers', 'srogers26@earthlink.net', 'Female', 'Philippines', '$9905.15'),
	(80, 'Christine', 'Bryant', 'cbryant27@sina.com.cn', 'Female', 'China', '$5473.56'),
	(81, 'Marilyn', 'Garrett', 'mgarrett28@netlog.com', 'Female', 'Thailand', '$5796.61'),
	(82, 'Denise', 'Campbell', 'dcampbell29@msn.com', 'Female', 'China', '$4418.34'),
	(83, 'Julia', 'Carter', 'jcarter2a@hostgator.com', 'Female', 'Indonesia', '$4559.31'),
	(84, 'Aaron', 'Hansen', 'ahansen2b@ucla.edu', 'Male', 'China', '$7038.80'),
	(85, 'Kathleen', 'Sullivan', 'ksullivan2c@pbs.org', 'Female', 'Brazil', '$8923.01'),
	(86, 'Louis', 'Hunter', 'lhunter2d@earthlink.net', 'Male', 'Japan', '$4697.44'),
	(87, 'Justin', 'Meyer', 'jmeyer2e@mozilla.com', 'Male', 'Russia', '$9518.54'),
	(88, 'Jeremy', 'Fisher', 'jfisher2f@amazon.com', 'Male', 'Indonesia', '$7366.84'),
	(89, 'Bonnie', 'Foster', 'bfoster2g@xinhuanet.com', 'Female', 'Peru', '$1170.36'),
	(90, 'Richard', 'Barnes', 'rbarnes2h@redcross.org', 'Male', 'Czech Republic', '$3607.48'),
	(91, 'Joseph', 'Sims', 'jsims2i@sina.com.cn', 'Male', 'Serbia', '$3428.19'),
	(92, 'Robert', 'Reid', 'rreid2j@msn.com', 'Male', 'China', '$5009.82'),
	(93, 'Lawrence', 'Stewart', 'lstewart2k@issuu.com', 'Male', 'Indonesia', '$1778.10'),
	(94, 'Jennifer', 'Bailey', 'jbailey2l@zimbio.com', 'Female', 'Russia', '$8699.96'),
	(95, 'Patrick', 'Parker', 'pparker2m@time.com', 'Male', 'Portugal', '$2330.71'),
	(96, 'Phillip', 'Miller', 'pmiller2n@bbc.co.uk', 'Male', 'China', '$8194.18'),
	(97, 'Betty', 'Smith', 'bsmith2o@tuttocitta.it', 'Female', 'Netherlands', '$2273.54'),
	(98, 'Phillip', 'Howard', 'phoward2p@cocolog-nifty.com', 'Male', 'Morocco', '$4391.79'),
	(99, 'George', 'Franklin', 'gfranklin2q@w3.org', 'Male', 'China', '$5294.81'),
	(100, 'Irene', 'Lane', 'ilane2r@youku.com', 'Female', 'Finland', '$2372.10'),
	(101, 'Ronald', 'Miller', 'rmiller2s@smh.com.au', 'Male', 'Philippines', '$8145.50'),
	(102, 'Sean', 'Myers', 'smyers2t@wisc.edu', 'Male', 'Slovenia', '$2996.92'),
	(103, 'Timothy', 'Perkins', 'tperkins2u@devhub.com', 'Male', 'United States', '$3739.23'),
	(104, 'Lois', 'Marshall', 'lmarshall2v@wix.com', 'Female', 'Spain', '$8990.87'),
	(105, 'Bonnie', 'Harrison', 'bharrison2w@baidu.com', 'Female', 'Ukraine', '$5517.16'),
	(106, 'Judith', 'Vasquez', 'jvasquez2x@constantcontact.com', 'Female', 'Iran', '$7899.36'),
	(107, 'Ryan', 'Morales', 'rmorales2y@washington.edu', 'Male', 'Uganda', '$4815.73'),
	(108, 'Jose', 'Larson', 'jlarson2z@gnu.org', 'Male', 'Portugal', '$1004.75'),
	(109, 'Anthony', 'Murray', 'amurray30@mysql.com', 'Male', 'China', '$2793.57'),
	(110, 'Thomas', 'Gutierrez', 'tgutierrez31@baidu.com', 'Male', 'United States', '$1775.25'),
	(111, 'Mildred', 'Wheeler', 'mwheeler32@tumblr.com', 'Female', 'Japan', '$6651.52'),
	(112, 'Ann', 'Stephens', 'astephens33@booking.com', 'Female', 'France', '$5034.33'),
	(113, 'Richard', 'Campbell', 'rcampbell34@xrea.com', 'Male', 'Russia', '$8250.37'),
	(114, 'Lisa', 'Duncan', 'lduncan35@tmall.com', 'Female', 'Netherlands', '$4138.15'),
	(115, 'Adam', 'Wheeler', 'awheeler36@dagondesign.com', 'Male', 'Puerto Rico', '$5822.79'),
	(116, 'Julia', 'Cooper', 'jcooper37@people.com.cn', 'Female', 'China', '$2316.91'),
	(117, 'Cheryl', 'Fisher', 'cfisher38@opera.com', 'Female', 'France', '$5089.72'),
	(118, 'Jimmy', 'Garza', 'jgarza39@techcrunch.com', 'Male', 'Russia', '$9357.32'),
	(119, 'Jimmy', 'Ford', 'jford3a@themeforest.net', 'Male', 'Peru', '$6818.65'),
	(120, 'Evelyn', 'Cole', 'ecole3b@fema.gov', 'Female', 'Philippines', '$5368.90'),
	(121, 'Bonnie', 'Elliott', 'belliott3c@latimes.com', 'Female', 'Indonesia', '$5504.88'),
	(122, 'Sharon', 'Jacobs', 'sjacobs3d@google.co.jp', 'Female', 'Azerbaijan', '$1652.41'),
	(123, 'Daniel', 'Foster', 'dfoster3e@people.com.cn', 'Male', 'Bermuda', '$7671.54'),
	(124, 'Chris', 'Young', 'cyoung3f@example.com', 'Male', 'Brazil', '$9124.91'),
	(125, 'Steven', 'Lynch', 'slynch3g@google.co.jp', 'Male', 'United States', '$4417.39'),
	(126, 'Marilyn', 'Black', 'mblack3h@utexas.edu', 'Female', 'Indonesia', '$4920.35'),
	(127, 'Carolyn', 'Cruz', 'ccruz3i@1und1.de', 'Female', 'Greece', '$8599.27'),
	(128, 'Louis', 'Vasquez', 'lvasquez3j@smh.com.au', 'Male', 'Indonesia', '$4480.09'),
	(129, 'Edward', 'Green', 'egreen3k@twitter.com', 'Male', 'China', '$1966.88'),
	(130, 'Jonathan', 'Wagner', 'jwagner3l@sina.com.cn', 'Male', 'Russia', '$4191.76'),
	(131, 'Edward', 'Burke', 'eburke3m@boston.com', 'Male', 'China', '$7316.83'),
	(132, 'Anna', 'Rogers', 'arogers3n@xinhuanet.com', 'Female', 'China', '$7710.56'),
	(133, 'Gregory', 'Murphy', 'gmurphy3o@cnet.com', 'Male', 'Portugal', '$4157.14'),
	(134, 'Ernest', 'Reyes', 'ereyes3p@washington.edu', 'Male', 'Nicaragua', '$5695.20'),
	(135, 'Doris', 'Riley', 'driley3q@printfriendly.com', 'Female', 'Armenia', '$3419.50'),
	(136, 'Martin', 'Webb', 'mwebb3r@virginia.edu', 'Male', 'China', '$9712.12'),
	(137, 'Elizabeth', 'Boyd', 'eboyd3s@spiegel.de', 'Female', 'Poland', '$9250.99'),
	(138, 'Teresa', 'Simmons', 'tsimmons3t@princeton.edu', 'Female', 'Indonesia', '$9053.45'),
	(139, 'Jesse', 'Warren', 'jwarren3u@google.co.uk', 'Male', 'China', '$8368.18'),
	(140, 'Joan', 'Andrews', 'jandrews3v@cmu.edu', 'Female', 'Russia', '$4847.95'),
	(141, 'Patrick', 'Harris', 'pharris3w@jimdo.com', 'Male', 'Indonesia', '$9534.81'),
	(142, 'Teresa', 'Meyer', 'tmeyer3x@un.org', 'Female', 'Honduras', '$3215.53'),
	(143, 'Lawrence', 'Little', 'llittle3y@blog.com', 'Male', 'Sweden', '$1588.32'),
	(144, 'Steve', 'Meyer', 'smeyer3z@cnbc.com', 'Male', 'China', '$8056.89'),
	(145, 'Shirley', 'Watson', 'swatson40@naver.com', 'Female', 'Philippines', '$2391.87'),
	(146, 'Kimberly', 'Taylor', 'ktaylor41@list-manage.com', 'Female', 'United States', '$8653.04'),
	(147, 'Walter', 'Morris', 'wmorris42@dmoz.org', 'Male', 'Brazil', '$3166.18'),
	(148, 'Jennifer', 'Olson', 'jolson43@umn.edu', 'Female', 'France', '$7189.35'),
	(149, 'Richard', 'Mcdonald', 'rmcdonald44@comcast.net', 'Male', 'Thailand', '$5778.44'),
	(150, 'Sandra', 'Reid', 'sreid45@salon.com', 'Female', 'Russia', '$6668.62'),
	(151, 'Catherine', 'Kelly', 'ckelly46@liveinternet.ru', 'Female', 'Peru', '$2634.98'),
	(152, 'Nancy', 'Myers', 'nmyers47@nhs.uk', 'Female', 'Bulgaria', '$5571.85'),
	(153, 'Matthew', 'Marshall', 'mmarshall48@army.mil', 'Male', 'Serbia', '$7525.85'),
	(154, 'Donna', 'Rogers', 'drogers49@ameblo.jp', 'Female', 'Greece', '$4360.36'),
	(155, 'Janice', 'Williamson', 'jwilliamson4a@alexa.com', 'Female', 'Indonesia', '$8617.74'),
	(156, 'Mark', 'Fields', 'mfields4b@patch.com', 'Male', 'China', '$4228.51'),
	(157, 'Eric', 'Oliver', 'eoliver4c@buzzfeed.com', 'Male', 'Argentina', '$3153.98'),
	(158, 'Raymond', 'Carroll', 'rcarroll4d@time.com', 'Male', 'Uganda', '$8220.10'),
	(159, 'Christine', 'Robertson', 'crobertson4e@independent.co.uk', 'Female', 'France', '$7612.12'),
	(160, 'Thomas', 'Jordan', 'tjordan4f@smh.com.au', 'Male', 'Thailand', '$3777.70'),
	(161, 'Keith', 'Rivera', 'krivera4g@theglobeandmail.com', 'Male', 'Sweden', '$1948.05'),
	(162, 'Victor', 'Johnson', 'vjohnson4h@zdnet.com', 'Male', 'China', '$9209.77'),
	(163, 'Virginia', 'Barnes', 'vbarnes4i@posterous.com', 'Female', 'Afghanistan', '$5568.58'),
	(164, 'Jonathan', 'Wright', 'jwright4j@state.gov', 'Male', 'United States', '$4848.25'),
	(165, 'Louis', 'Lane', 'llane4k@apple.com', 'Male', 'Russia', '$2387.71'),
	(166, 'Tammy', 'James', 'tjames4l@statcounter.com', 'Female', 'Peru', '$2464.19'),
	(167, 'Richard', 'Lynch', 'rlynch4m@amazon.com', 'Male', 'Thailand', '$6525.60'),
	(168, 'Edward', 'Burns', 'eburns4n@infoseek.co.jp', 'Male', 'Paraguay', '$1420.87'),
	(169, 'Anthony', 'Woods', 'awoods4o@reuters.com', 'Male', 'Philippines', '$4246.10'),
	(170, 'Carol', 'Harris', 'charris4p@foxnews.com', 'Female', 'Sri Lanka', '$4483.90'),
	(171, 'Donald', 'Hughes', 'dhughes4q@spotify.com', 'Male', 'Thailand', '$8917.97'),
	(172, 'Katherine', 'Stone', 'kstone4r@narod.ru', 'Female', 'Indonesia', '$5852.63'),
	(173, 'Donna', 'Oliver', 'doliver4s@auda.org.au', 'Female', 'Afghanistan', '$7140.97'),
	(174, 'Catherine', 'Simmons', 'csimmons4t@java.com', 'Female', 'Peru', '$1165.64'),
	(175, 'Jose', 'Reed', 'jreed4u@patch.com', 'Male', 'China', '$8883.90'),
	(176, 'Robin', 'Day', 'rday4v@clickbank.net', 'Female', 'Indonesia', '$8293.61'),
	(177, 'Benjamin', 'Reed', 'breed4w@dailymotion.com', 'Male', 'Ghana', '$2117.74'),
	(178, 'Johnny', 'Oliver', 'joliver4x@nifty.com', 'Male', 'Serbia', '$9483.68'),
	(179, 'Douglas', 'Brooks', 'dbrooks4y@ow.ly', 'Male', 'Russia', '$9578.75'),
	(180, 'Rebecca', 'Wallace', 'rwallace4z@google.com.br', 'Female', 'Egypt', '$2430.79'),
	(181, 'Ashley', 'Bailey', 'abailey50@smh.com.au', 'Female', 'China', '$2438.13'),
	(182, 'Sarah', 'Burns', 'sburns51@comsenz.com', 'Female', 'Uganda', '$4970.99'),
	(183, 'Theresa', 'Clark', 'tclark52@sfgate.com', 'Female', 'China', '$4257.72'),
	(184, 'Roger', 'Chavez', 'rchavez53@abc.net.au', 'Male', 'China', '$5476.22'),
	(185, 'Clarence', 'Franklin', 'cfranklin54@prlog.org', 'Male', 'Sweden', '$6533.25'),
	(186, 'Scott', 'Harris', 'sharris55@google.com', 'Male', 'Russia', '$6830.77'),
	(187, 'Jack', 'Hunter', 'jhunter56@auda.org.au', 'Male', 'Indonesia', '$5569.02'),
	(188, 'Harold', 'King', 'hking57@1688.com', 'Male', 'United States', '$8603.95'),
	(189, 'Harold', 'Ramos', 'hramos58@adobe.com', 'Male', 'France', '$1543.30'),
	(190, 'Henry', 'Stewart', 'hstewart59@edublogs.org', 'Male', 'Colombia', '$1932.31'),
	(191, 'Charles', 'Brown', 'cbrown5a@yellowbook.com', 'Male', 'Mexico', '$6673.96'),
	(192, 'Keith', 'Perkins', 'kperkins5b@adobe.com', 'Male', 'Madagascar', '$9856.92'),
	(193, 'Lisa', 'Martinez', 'lmartinez5c@hubpages.com', 'Female', 'Philippines', '$5697.85'),
	(194, 'Samuel', 'Rose', 'srose5d@mit.edu', 'Male', 'Macedonia', '$6780.83'),
	(195, 'Andrea', 'Harrison', 'aharrison5e@redcross.org', 'Female', 'Indonesia', '$2090.73'),
	(196, 'Maria', 'Matthews', 'mmatthews5f@cbc.ca', 'Female', 'United States', '$2018.75'),
	(197, 'Brenda', 'Ortiz', 'bortiz5g@epa.gov', 'Female', 'United States', '$8283.32'),
	(199, 'Janet', 'Cox', 'jcox5i@state.tx.us', 'Female', 'Sweden', '$3595.23'),
	(200, 'Amanda', 'Collins', 'acollins5j@storify.com', 'Female', 'United States', '$4954.53');
/*!40000 ALTER TABLE `bootgrid_data` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дамп данных таблицы sfts_courses.migrations: ~2 rows (приблизительно)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`migration`, `batch`) VALUES
	('2014_10_12_000000_create_users_table', 1),
	('2014_10_12_100000_create_password_resets_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.password_resets
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дамп данных таблицы sfts_courses.password_resets: ~0 rows (приблизительно)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;


-- Дамп структуры для таблица sfts_courses.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Дамп данных таблицы sfts_courses.users: ~2 rows (приблизительно)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(2, 'algo', 'algosoft@mail.ru', '$2y$10$1ZUtyrnVhL0hvbIXD0p5BuWZFRu93606iD/Nm7v/bG0knqZJt5wVK', 'laIKkd5xkPdHZtbwovx9Z3MOC4X1IetjZAIHw1vpYCM29kFxsy4Os5BICncd', '2016-08-26 21:13:13', '2016-08-27 21:26:30'),
	(3, 'immarketing', 'immarketing@mail.ru', '$2y$10$gfAh9fJSLU/.dTTMPuIAwuSoiDnLk0oIulfOhjEqYasCCpxXeEbAy', 'ZS0a3EeiYMosIpZITLONO7J8TbamIMqSEyyNxkWW3b6g076mvUgwCaid9M4c', '2017-01-30 13:55:17', '2017-01-30 13:55:17');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
