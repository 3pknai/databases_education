-- 1. Вывести список курсов, которые проходит конкретный пользователь
SELECT user.Name AS username,
	   course.Name AS coursename
FROM `user to course`
JOIN course ON `user to course`.`Course_Short name` = `course`.`Short name`
JOIN user ON `user to course`.User_Login = user.Login
ORDER BY username;

-- 2. Вывести список непрочитанных уведомлений для конкретного пользователя
SELECT user.Name AS userName,
	   notification.Name AS Title
FROM `user to notification`
JOIN user ON user.Login = `user to notification`.User_Login
JOIN notification ON notification.id_notification = `user to notification`.Notification_id_notification
WHERE NOT `user to notification`.Read
ORDER BY user.Name;

-- 3. Вывести список активных тестов (те, которые уже начались, но ещё не закончились) на платформе
SELECT id_test
FROM testing
WHERE End_date > CURRENT_DATE();

-- 4. Вывести список самых популярных курсов на платформе (не больше 5)
SELECT `Short name`,
	   Name,
	   Rating
FROM course
ORDER BY Rating DESC
LIMIT 5;

-- 5. Вывести количество пользователей,записанных хотя бы на один курс
SELECT COUNT(DISTINCT(`user to course`.User_Login)) AS Count
FROM `user to course`;

-- 6. Вывести пути до всех файлов на сервере, используемых в элементах курса
SELECT DISTINCT(Attached_file) AS filename
FROM `course element`
WHERE NOT Attached_file IS NULL
ORDER BY filename;

-- 7. Вывести цену самого дорогого курса на платформе
SELECT course.Name,
	   payment.Price
FROM course
JOIN payment ON payment.id_payment = course.Payment_id_payment
WHERE payment.Price = (SELECT MAX(Price) FROM payment);

-- 8. Вывести количество пользователей с ролью «Преподаватель»
SELECT COUNT(DISTINCT(User_Login)) AS count_prepod
FROM `user to course`
WHERE Role = "Преподаватель";

-- 9. Вывести количество скрытых элементов конкретного курса
SELECT course.`Short name` AS course_name,
	   COUNT(`course element`.Visibility) AS Visible_elements
FROM `content bank`
JOIN course ON course.`Content bank_id_content_bank` = `content bank`.id_content_bank
JOIN `course element` ON `course element`.`Content bank_id_content_bank` = `content bank`.id_content_bank
GROUP BY course_name;

-- 10. Вывести средний возраст пользователей на платформе
SELECT AVG(TIMESTAMPDIFF(YEAR, Date_of_birth, CURRENT_DATE)) AS 'Средний возраст пользователей на платформе'
FROM user;

-- 11. Вывод id теста, количество вопросов в тесте и суммарный балл за правильное прохождение теста
SELECT Testing_id_test AS test_id,
	   SUM(question.Score_for_correct_execution) AS total_score,
       COUNT(`testing to question`.Testing_id_test) AS count_question_in_test
FROM `testing to question`
JOIN question ON question.id_question = `testing to question`.Question_id_question
GROUP BY `testing to question`.Testing_id_test
ORDER BY test_id;

-- 12. Вывод id теста, логина пользователя и суммарный балл, который пользователь смог набрать
SELECT `testing to question`.Testing_id_test AS test_id,
	   user.Login,
       SUM(`user to question`.The_score_received) AS sum_score
FROM `user to question`
JOIN user ON `user to question`.User_Login = user.Login
JOIN question ON question.id_question = `user to question`.Question_id_question
JOIN `testing to question` ON `testing to question`.Question_id_question = question.id_question
WHERE question.id_question IN (SELECT Question_id_question FROM `testing to question` WHERE Testing_id_test = `testing to question`.Testing_id_test)
GROUP BY user.Login, `testing to question`.Testing_id_test
ORDER BY test_id, user.Login, sum_score;

-- 13. Вывести процент правильно выполненных вопросов тестирования для
-- каждого теста и каждого пользователя
SELECT t1.test_id,
	   t2.Login,
       t2.sum_score,
       t1.total_score,
       t2.sum_score / t1.total_score * 100 AS percent
FROM (SELECT Testing_id_test AS test_id,
		   SUM(question.Score_for_correct_execution) AS total_score
	FROM `testing to question`
	JOIN question ON question.id_question = `testing to question`.Question_id_question
	GROUP BY `testing to question`.Testing_id_test)
    AS t1
JOIN (SELECT `testing to question`.Testing_id_test AS test_id,
		   user.Login,
		   SUM(`user to question`.The_score_received) AS sum_score
	FROM `user to question`
	JOIN user ON `user to question`.User_Login = user.Login
	JOIN question ON question.id_question = `user to question`.Question_id_question
	JOIN `testing to question` ON `testing to question`.Question_id_question = question.id_question
	WHERE question.id_question IN (SELECT Question_id_question FROM `testing to question`
								   WHERE Testing_id_test = `testing to question`.Testing_id_test)
	GROUP BY user.Login, `testing to question`.Testing_id_test)
    AS t2
ON t1.test_id = t2.test_id
ORDER BY t2.test_id, t2.Login;

-- 14. Вывести активных пользователей на сайте (которые были на платформе в течении последних 10-ти минут)
-- и время, которое прошло с момента их последней активности на платформе
SELECT Login,
	   TIMESTAMPDIFF(MINUTE, The_time_of_the_last_access_to_the_system, CURRENT_TIME) AS minute
FROM user
WHERE TIMESTAMPDIFF(MINUTE, The_time_of_the_last_access_to_the_system, CURRENT_TIME) <= 10;

-- 15. Вывести список email-ов и уведомлений, которые нужно отправить пользователю
-- (на email пользователя придёт текст уведомления, которого он не прочитал на платформе)
SELECT user.Mail,
	   CONCAT("noreply: ", notification.Name) AS title,
	   CONCAT("Вы пропустили сообщение от нас на платформе, поэтому оповещаем Вас! ", notification.Text) AS text
FROM `user to notification`
JOIN user ON user.Login = `user to notification`.User_Login
JOIN notification ON notification.id_notification = `user to notification`.Notification_id_notification
WHERE `user to notification`.Read = 0;
