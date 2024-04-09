-- 1. Сделать частичнодоступным банк контента с заданным айди
UPDATE `content bank`
SET Access_rights = "Частичнодоступный"
WHERE id_content_bank = 8;

-- 2. Сделать преподавателем в конкретном курсе пользователя с конкретным именем
UPDATE `user to course`
SET Role = "Преподаватель"
WHERE User_Login = "3pknai"
	AND `Course_Short name` = "frontend202";

-- 3. Сделать все уведомления для всех пользователей, у которых в поле Почта
-- нету подстроки "mail", прочитанными
UPDATE `user to notification`
JOIN user ON user.Login = `user to notification`.User_Login
SET `Read` = 1
WHERE "mail" NOT IN (user.Mail);

-- 4. Сделать Редакторами пользователей из списка в блогах из списка (если пользователи 
-- уже имеют в этих блогах какую-то роль, отличную от редактора)
UPDATE `user to blog`
SET Privilege = "Редактор"
WHERE User_Login IN ("lisa01", "rharper75")
	AND Blog_id_blog IN (1, 3);
    
-- 5. В вопросах, которые имеют не целое значение максимального балла, сделать это
-- значение целым
UPDATE question
SET Score_for_correct_execution = Score_for_correct_execution + (1 - Score_for_correct_execution % 1)
WHERE Score_for_correct_execution % 1 <> 0;

-- 6. Обновление баллов студентов за вопрос при смене балла за правильное выполнение вопроса
-- (доля полученного балла должна оставаться прежней) (для примера сменим балл для второго вопроса на 30)
UPDATE `user to question`
SET The_score_received = (The_score_received / (SELECT Score_for_correct_execution
											   FROM question WHERE id_question = 2) * 100) div 1 / 100 * 30
WHERE Question_id_question = 2;
UPDATE question
SET Score_for_correct_execution = 30
WHERE id_question = 2;

-- 7. Сделать прочитанным конкретное уведомление у конкретного пользователя
UPDATE `user to notification`
SET `user to notification`.Read = 1
WHERE User_Login = "3pknai" AND Notification_id_notification = 1;