-- 1. Представление для полной информации о курсах
CREATE VIEW course_info
AS SELECT Name AS course_name,
	   Duration,
       The_beginning_of_the_course,
       Rating,
       forum.Number_of_messages,
       payment.Price,
       payment.Commission,
       `content bank`.Location_on_the_server
FROM course
JOIN forum ON forum.id_forum = course.Forum_id_forum
JOIN payment ON payment.id_payment = Payment_id_payment
JOIN `content bank` ON `content bank`.id_content_bank = `Content bank_id_content_bank`
ORDER BY The_beginning_of_the_course, course_name;

SELECT *
FROM course_info
WHERE Price > 7000;

-- 2. Получить список пользователей и их оценок, включая тех, у которых нет оценок
CREATE VIEW user_score
AS SELECT user.Login,
	   user.Country,
	   `user to question`.The_score_received,
       question.id_question,
       question.Score_for_correct_execution,
       question.Type
FROM question
RIGHT JOIN `user to question` ON `user to question`.Question_id_question = question.id_question
RIGHT JOIN user ON user.Login = `user to question`.User_Login;

SELECT * FROM user_score
WHERE The_score_received * 2 > Score_for_correct_execution;

-- 3. Вывести список вопросов для каждого теста (в котором даже нет вопросов), отсортированных по номеру вопроса в тесте
CREATE VIEW test_question
AS SELECT id_test,
	   `testing to question`.Question_id_question AS id_question,
       `testing to question`.Number AS number
FROM testing
LEFT JOIN `testing to question` ON `testing to question`.Testing_id_test = id_test
ORDER BY id_test, number;

SELECT *
FROM test_question
WHERE id_test IN (4, 67, 135, 907, 16);