-- 0. Создание новой вспомогательной таблицы
CREATE TABLE IF NOT EXISTS `Online learning platform`.`User_rec` (
  `Login` VARCHAR(26) NOT NULL, -- [4, 26]
  `Name` VARCHAR(50) NOT NULL, -- [4, 50]
  `Mail` VARCHAR(50) NOT NULL, -- [4, 50]
  PRIMARY KEY (`Login`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Online learning platform`.`Courses_rating` (
  `Name` VARCHAR(50) NOT NULL, -- [4, 50]
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- 1. Выгрузить в новую таблицу пользователей (Их логина, имени и email),
-- которые в курсе имеют роль преподавателя
INSERT INTO `User_rec` (Login, Name, Mail)
SELECT DISTINCT(Login), Name, Mail
FROM user
JOIN `user to course` ON `user to course`.User_Login = user.Login
WHERE `user to course`.Role = "Преподаватель";

-- 2. Выгрузить в новую таблицу название курсов, которые имеют рейтинг > 4.7
INSERT INTO `Courses_rating`
SELECT Name
FROM course
WHERE Rating > 4.7;

-- 3. Вставить в новосозданную таблицу пользователей новые записи
INSERT INTO `User_rec` (Login, Name, Mail)
VALUES
("iklyaM", "Матохин И. Г.", "iklyaM@yandex.ru"),
("voprak", "Карпов А. В.", "voprak@mail.ru"),
("VirmLeed", "Зенин М. А.", "virmleed@gmail.com");