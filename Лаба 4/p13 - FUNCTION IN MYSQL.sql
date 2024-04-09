-- 1. Вывести всю информацию о блоге, предварительно преобразовав заголовок к верхнему регистру
SELECT id_blog, Date_of_publication, Title, UCASE(Content) AS text
FROM blog;

-- 2. Вывод названия курса и рейтинга этого курса (если рейтинг >= 4.75, то вывести "высокий",
-- если рейтинг >= 4.5, то вывести "средний", иначе - "низкий")
SELECT `Short name`, IF(Rating >= 4.75, "высокий", IF(Rating >= 4.5, "средний", "низкий")) AS rating
FROM course;

-- 3. Вывести балл за правильный ответ на вопрос в двоичном формате
SELECT id_question, BIN(Score_for_correct_execution) AS score
FROM question;

-- 4. Вывести балл, полученный пользователем в дробном и в целом формате
SELECT User_Login, Question_id_question, The_score_received, CONVERT(The_score_received, UNSIGNED) AS convert_score
FROM `user to question`;

-- 5. Вывод содержимого вопроса в сокращённом формате (первые 25 символов и потом ...)
SELECT id_question, CONCAT(LEFT(Text, 25), "...") AS text
FROM question;

-- 6. Вывод часа, дня, недели окончания каждого тестирования
SELECT id_test, HOUR(End_date) AS hour, DAY(End_date) AS day, WEEK(End_date) AS week
FROM testing;

-- 7. Вывод разницы в минутах между текущим временем и временем последнего доступа к курсу каждого пользователя
SELECT Login, TIMESTAMPDIFF(MINUTE, The_time_of_the_last_access_to_the_system, CURRENT_TIME) AS minutes
FROM user;

-- 8. Вывод уведомления и даты его отправки
SELECT id_notification, CONVERT(Date_of_dispatch, DATE)
FROM notification;
