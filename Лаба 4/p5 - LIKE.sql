-- 1. Выбор всех имён курсов с подстрокой "end" в коротком названии курса
SELECT Name
FROM course
WHERE `Short name` LIKE "%end%";

-- 2. Выбор всех блогов, в заголовке или в содержимом которых есть подстрока "Как"
SELECT *
FROM blog
WHERE Content LIKE "%Как%";

-- 3. Выбор списка форумов, предмет обсуждения которых начинается со слова "Как"
-- и оканчиваются на знак вопроса
SELECT *
FROM forum
WHERE The_subject_of_the_question LIKE "Как%?";

-- 4. Выбор всех уведомлений, внутри которых есть слово Обновление без учёта регистра
SELECT *,
	   length(Name) / 2
FROM notification
WHERE LOWER(Text) LIKE "%обновление%";

-- 5. Выбор всех элементов курса, внутри названия которых содержатся подстроки "Тест"
-- или "Результат"
SELECT *
FROM `course element`
WHERE Name LIKE "%Тест%" OR Name LIKE "%Результат%";

-- 6. Выбор всех имён пользоветелей с почтой, оканчивающейся на "@gmail.com"
SELECT Name,
	   mail
FROM user
WHERE mail LIKE "%@gmail.com";

-- 7. Выбор всех номеров телефонов пользователей удовлетворяющих шаблону "___-____"
SELECT Telephone
FROM user
WHERE Telephone LIKE "___-____";

-- 8. Выбор всех банков контента, у которых расположение на сервере удовлетворяет
-- шаблону "/courses/bank_"
SELECT *
FROM `content bank`
WHERE Location_on_the_server LIKE("/courses/bank_");

-- 9. Выбор всех пользователей в конкретном курсе у которых имя начинается на конкретную букву
SELECT user.Name,
	   user.Mail,
       Role
FROM `user to course`
JOIN user ON user.Login = User_Login
WHERE `Course_Short name` = "frontend202"
	AND user.Name LIKE "Б%";