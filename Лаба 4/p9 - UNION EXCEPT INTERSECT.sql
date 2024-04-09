-- 1. Объединить имена всех пользователей, которые получили балл за ответ на вопрос с индексом 1
-- с именами пользователей, которые имеют непрочитанные сообщения со словом "функционал"
SELECT User_Login
FROM `user to question`
WHERE Question_id_question = 1
UNION
SELECT User_Login
FROM `user to notification`
JOIN notification ON notification.id_notification = Notification_id_notification
WHERE Text LIKE "%функционал%";

-- 2. Объединить всевозможные временные метки с какими-либо действиями на платформе
SELECT time
FROM 
(SELECT The_time_of_the_last_access_to_the_system AS Time FROM user
UNION
SELECT Creation_time AS Time FROM question
UNION 
SELECT Start_date AS Time FROM testing
UNION
SELECT End_date AS Time FROM testing
UNION
SELECT Date_of_dispatch AS Time FROM notification
UNION 
SELECT The_beginning_of_the_course AS Time FROM course
UNION
SELECT Date_of_publication AS Time FROM blog) AS t
ORDER BY 1;

-- 3. Объединение всевозможных привелегий в блогах и ролей в курсах
SELECT DISTINCT(Role)
FROM `user to course`
UNION
SELECT DISTINCT(Privilege)
FROM `user to blog`;

-- 4. Объединение всевозможных типов вопросов и типов нескрытых элементов курса
SELECT Type
FROM question
UNION
SELECT Type
FROM `course element`
WHERE Visibility != 0;