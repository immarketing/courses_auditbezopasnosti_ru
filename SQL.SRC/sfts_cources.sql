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
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
