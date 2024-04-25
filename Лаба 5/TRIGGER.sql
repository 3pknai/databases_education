-- Обновление баллов студентов за вопрос при смене балла за правильное выполнение вопроса
-- (доля полученного балла должна оставаться прежней)
DELIMITER $$
CREATE TRIGGER user_score AFTER UPDATE ON question
FOR EACH ROW
BEGIN
	UPDATE `user to question`
	SET The_score_received = (The_score_received /
    (SELECT OLD.Score_for_correct_execution
	FROM question WHERE id_question = OLD.id_question) * 100) div 1 / 100 * NEW.Score_for_correct_execution
	WHERE Question_id_question = OLD.id_question;
END $$
DELIMITER ;

SELECT *
FROM `user to question`
WHERE Question_id_question = 5
LIMIT 7;

SELECT *
FROM question
WHERE id_question = 5;

UPDATE question
SET Score_for_correct_execution = 30
WHERE id_question = 5;

SELECT *
FROM `user to question`
WHERE Question_id_question = 5
LIMIT 7;

SELECT *
FROM question
WHERE id_question = 5;

UPDATE question
SET Score_for_correct_execution = 50
WHERE id_question = 5;