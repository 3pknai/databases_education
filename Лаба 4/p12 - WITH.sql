-- 1. Вывести список вопросов, принадлежащих курсам, в которых рейтинг = 4.5
WITH tests AS
(SELECT id_test FROM testing
JOIN `content bank` ON `content bank`.id_content_bank = testing.`Content bank_id_content_bank`
JOIN course ON `content bank`.id_content_bank = course.`Content bank_id_content_bank`
WHERE course.Rating = 4.5)

SELECT id_test,
	   `testing to question`.Question_id_question AS id_question
FROM tests
LEFT JOIN `testing to question` ON `testing to question`.Testing_id_test = id_test;

-- 2. Вывести список вопросов и тестирований в порядке следования в тесте, которые имеют больше 15 баллов за правильное выполнение
WITH tests_question AS
(SELECT Testing_id_test, Question_id_question, Number FROM `testing to question`
ORDER BY Testing_id_test, Number)

SELECT Testing_id_test, Question_id_question, Number, question.Score_for_correct_execution
FROM tests_question
JOIN question ON question.id_question = Question_id_question
WHERE Score_for_correct_execution > 15
ORDER BY Testing_id_test, Number;
