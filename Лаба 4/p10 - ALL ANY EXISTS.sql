-- 1. Получить список пользователей, которые записались хотя бы на какой-нибудь курс
SELECT Login
FROM user
WHERE Login = ANY(SELECT User_Login FROM `user to course`);

-- 2. Получить список курсов, у которых рейтинг меньше, чем у курсов длящихся дольше 45 часов
SELECT `Short name`,
	   Rating
FROM course
WHERE Rating < ALL(SELECT Rating FROM course WHERE Duration > 45);

-- 3. Получить список курсов, в которых нету ни одного пользователя
SELECT `Short name`
FROM course
WHERE NOT EXISTS (SELECT * FROM `user to course` WHERE course.`Short name` = `user to course`.`Course_Short name`);
