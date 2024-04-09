-- 1. Удалить вопрос с указанным id
DELETE FROM question
WHERE id_question = 10;

-- 2. Удалить всех учеников из курса с конкретным названием
DELETE FROM `user to course`
WHERE `Course_Short name` = "python201"
	AND Role = "Ученик";
    
-- 3. Удалить все скрытые элементы курса, у которых отсутствует прикреплённый файл
DELETE FROM `course element`
WHERE Visibility = 0
	AND Attached_file IS NULL;
    
-- 4. Удалить из указанного банка контента тестирования, которые уже закончились
DELETE FROM testing
WHERE `Content bank_id_content_bank` = 1
	AND CURRENT_DATE() > End_date;
    
-- 5. Удалить всех пользователей из списка
DELETE FROM user
WHERE Login IN ('nicole39', 'mary234');