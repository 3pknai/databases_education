-- 1. INNER JOIN для таблицы курс + пользователь (указывается пользователь и роли,
-- которыми он обладает во всех курсах)
SELECT DISTINCT(user.Name),
	   `user to course`.Role
FROM `user to course`
INNER JOIN user ON user.Login = `user to course`.User_Login;

-- 2. JOIN для таблицы курс + оплата (добавление подробностей оплаты)
SELECT `Short name`,
	   Name,
       Rating,
       The_beginning_of_the_course,
       payment.Price,
       payment.Commission
FROM course
JOIN payment ON course.Payment_id_payment = payment.id_payment;

-- 3. JOIN для таблицы курс + банк контента + тестирование
SELECT course.Name AS coursename,
	   id_content_bank,
       testing.Start_date,
       testing.End_date
FROM testing
JOIN `content bank` ON `content bank`.id_content_bank = testing.`Content bank_id_content_bank`
JOIN course ON course.`Content bank_id_content_bank` = `content bank`.id_content_bank;

-- 4. LEFT JOIN для банка контента + тестирования
SELECT id_content_bank,
	   Access_rights,
       id_test,
       Start_date,
       End_date
FROM `content bank`
LEFT JOIN testing ON `content bank`.id_content_bank = testing.`Content bank_id_content_bank`;

-- 5. RIGHT JOIN для пользователя + вопрос (получить список пользователей и их оценок, включая тех, у которых нет оценок)
SELECT user.Login,
	   user.Country,
	   `user to question`.The_score_received,
       question.id_question,
       question.Score_for_correct_execution,
       question.Type
FROM question
RIGHT JOIN `user to question` ON `user to question`.Question_id_question = question.id_question
RIGHT JOIN user ON user.Login = `user to question`.User_Login;

-- 6. CROSS JOIN для пользователей курсов и ролей, которыми обладает или не обладает
-- пользователь в этих курсах
SELECT user.Login,
	   course.`Short name`,
       `user to course`.Role
FROM user
CROSS JOIN course
LEFT JOIN `user to course` ON `user to course`.`User_Login` = user.Login
	AND `user to course`.`Course_Short name` = course.`Short name`;
    
-- 7. Получить список всех возможных комбинаций пользователей и уведомлений
SELECT User_Login,
	   Notification_id_notification AS id_notification,
       notification.Name
FROM `user to notification`
CROSS JOIN notification
ORDER BY id_notification;

-- 8. Получить список курсов (название курса, длительность, начало курса, рейтинг), включая дополнительную информацию
-- (форум: количество сообщений; оплата: цена, комиссия; банк контента: расположение)
SELECT Name AS course_name,
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

-- 9. Получить список элементов внутри каждого банка контента
SELECT `Content bank_id_content_bank`, 
	   Number,
       Name,
       Type,
       Visibility
FROM `course element`
JOIN `content bank` ON `content bank`.id_content_bank = `Content bank_id_content_bank`
ORDER BY id_content_bank, Number;

-- 10. Получить список пользователей и их принадлежности блогам
SELECT Login,
	   The_time_of_the_last_access_to_the_system,
       `user to blog`.Blog_id_blog,
       `user to blog`.Privilege
FROM user
JOIN `user to blog` ON Login = `user to blog`.User_Login;

-- 11. Вывести список вопросов для каждого теста (в котором даже нет вопросов), отсортированных по номеру вопроса в тесте
SELECT id_test,
	   `testing to question`.Question_id_question AS id_question,
       `testing to question`.Number AS number
FROM testing
LEFT JOIN `testing to question` ON `testing to question`.Testing_id_test = id_test
ORDER BY id_test, number;

-- 12. Вывести список вопросов, и курсы к которым они принадлежат (если вопрос не принадлежит ни одному
-- из курсов, то вывести null)
SELECT DISTINCT(id_question),
	   course.`Short name`
FROM question
LEFT JOIN `testing to question` ON `testing to question`.Question_id_question = id_question
LEFT JOIN testing ON testing.id_test = `testing to question`.Testing_id_test
LEFT JOIN `content bank` ON `content bank`.id_content_bank = testing.`Content bank_id_content_bank`
LEFT JOIN course ON course.`Content bank_id_content_bank` = `content bank`.id_content_bank;