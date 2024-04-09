-- 1. Вывести количество вопросов для каждого типа вопросов
SELECT Type AS question_type,
	   COUNT(*) AS count
FROM question
GROUP BY Type;

-- 2. Вывести топ-3 учеников в конкретном курсе (web101), которые имеют какие-нибудь баллы в этом курсе
SELECT t1.Login,
	   SUM(t1.sum_score) AS rating
FROM (SELECT `testing to question`.Testing_id_test AS test_id,
		   user.Login,
		   SUM(`user to question`.The_score_received) AS sum_score,
           testing.`Content bank_id_content_bank` AS bank_id
	  FROM `user to question`
	  JOIN user ON `user to question`.User_Login = user.Login
	  JOIN question ON question.id_question = `user to question`.Question_id_question
	  JOIN `testing to question` ON `testing to question`.Question_id_question = question.id_question
      JOIN testing ON `testing to question`.`Testing_id_test` = testing.id_test
	  WHERE question.id_question IN (SELECT Question_id_question FROM `testing to question` WHERE Testing_id_test = `testing to question`.Testing_id_test)
	  GROUP BY user.Login, `testing to question`.Testing_id_test)
	  AS t1
JOIN course ON course.`Content bank_id_content_bank` = t1.bank_id
WHERE course.`Short name` = "web101"
GROUP BY t1.Login
ORDER BY rating DESC
LIMIT 3;

-- 3. Вывести список вопросов в определённом тесте, в порядке их следования в этом тесте
SELECT Testing_id_test AS test_id,
	   Question_id_question AS question_id,
       Number
FROM `testing to question`
ORDER BY test_id, Number;

-- 4. Вывести список курсов, у которых рейтинг равен среднему рейтингу курсов на платформе (если такие курсы есть)
SELECT *
FROM course
WHERE rating = (SELECT AVG(rating) FROM course); 

-- 5. Вывести пользователя, который дольше всех не заходил на платформу
SELECT Login
FROM user
ORDER BY The_time_of_the_last_access_to_the_system
LIMIT 1;

-- 6. Вывести максимальное количество студентов в одном курсе
SELECT MAX(t.count) AS max_count
FROM (SELECT COUNT(*) AS count
	  FROM `user to course`
	  GROUP BY `Course_Short name`) AS t;

-- 7. Вывести список уведомлений для конкретного пользователя (от старых к новым)
SELECT User_Login,
	   Notification_id_notification,
       notification.Date_of_dispatch
FROM `user to notification`
JOIN notification ON Notification_id_notification = notification.id_notification
ORDER BY User_Login, notification.Date_of_dispatch;

-- 8. Посчитать возраст людей, записанных хотя бы на 2 курса на платформе, имеющих в курсе роль
-- отличную от преподавателя 
SELECT User_Login AS login,
	   COUNT(*) AS count_of_courses,
       TIMESTAMPDIFF(YEAR, user.Date_of_birth, CURRENT_DATE) AS age
FROM `user to course` 
JOIN user ON user.Login = `user to course`.User_Login
WHERE `user to course`.Role <> "Преподаватель"
GROUP BY User_Login
HAVING count_of_courses >= 2;

-- 9. Для каждого пользователя посчитать количество вопросов, на которые он когда либо
-- отвечал; суммарный балл, который он смог таким образом набрать; минимальный балл за какой-либо вопрос
-- (из решённых) и максимальный балл за какой-либо вопрос (из решённых)
SELECT User_Login,
	   COUNT(*) AS count_question,
	   SUM(The_score_received) AS sum_score,
       MIN(The_score_received) AS min_score,
       MAX(The_score_received) AS max_score
FROM `user to question`
JOIN question ON question.id_question = Question_id_question
GROUP BY User_Login;

-- 10. Вывести список вопросов для каждого тестирования в порядке создания вопроса (от самого нового
-- к самому старому)
SELECT Testing_id_test,
	   Question_id_question,
       question.Creation_time
FROM `testing to question`
JOIN question ON question.id_question = Question_id_question
ORDER BY Testing_id_test, question.Creation_time DESC;

-- 11. Отсортировать курсы по количеству сообщений на форуме этого курса (от большего к меньшему)
SELECT `Short name`,
	   Forum_id_forum,
       forum.Number_of_messages
FROM course
JOIN forum ON forum.id_forum = Forum_id_forum
ORDER BY forum.Number_of_messages DESC;

-- 12. Вывести количество пользователей, родившихся в определённый год
SELECT COUNT(*) AS count
FROM user
WHERE EXTRACT(YEAR FROM Date_of_birth) = 1998;

-- 13. Вывести список ролей для определённого курса (python201) и количество человек, имеющих данную роль
SELECT Role,
	   COUNT(*) AS count
FROM `user to course`
WHERE `Course_Short name` = "python201"
GROUP BY Role;

-- 14. Вывести количество уникальных вопросов в курсе (и количество вопросов, которые не принадлежат ни одному курсу)
SELECT course.`Short name` AS course_name, 
	   COUNT(DISTINCT(id_question)) AS count
FROM question
LEFT JOIN `testing to question` ON `testing to question`.Question_id_question = id_question
LEFT JOIN testing ON testing.id_test = `testing to question`.Testing_id_test
LEFT JOIN `content bank` ON `content bank`.id_content_bank = testing.`Content bank_id_content_bank`
LEFT JOIN course ON course.`Content bank_id_content_bank` = `content bank`.id_content_bank
GROUP BY course.`Short name`
ORDER BY course_name DESC;

-- 15. Вывести максимальный и минимальный балл, который можно получить за ответ на один вопрос в тесте для каждого курса
SELECT course.`Short name`,
       MIN(question.Score_for_correct_execution) AS min,
	   MAX(question.Score_for_correct_execution) AS max
FROM course
JOIN `content bank` ON course.`Content bank_id_content_bank` = `content bank`.id_content_bank
LEFT JOIN testing ON `content bank`.id_content_bank = testing.`Content bank_id_content_bank`
LEFT JOIN `testing to question` ON testing.id_test = `testing to question`.Testing_id_test
LEFT JOIN question ON `testing to question`.Question_id_question = question.id_question
GROUP BY course.`Short name`
ORDER BY min DESC, max DESC;