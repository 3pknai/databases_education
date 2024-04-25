-- 1. Выбрать всех уникальных пользователей записанных на курсы
SELECT DISTINCT(User_Login)
FROM `user to course`;

-- 2. Выбрать всех пользователей на платформе старше 35 лет
SELECT Login,
	   TIMESTAMPDIFF(YEAR, Date_of_birth, CURRENT_DATE) AS AGE
FROM user
WHERE TIMESTAMPDIFF(YEAR, Date_of_birth, CURRENT_DATE) > 35;

-- 3. Выбрать всех пользователей и уведомления которые они не прочитали
SELECT User_Login,
	   Notification_id_notification
FROM `user to notification`
WHERE `Read` = 0;

-- 4. Выбрать всех связи между блогами и пользователями, в которых пользователь
-- является или редактором или создателем
SELECT *
FROM `user to blog`
WHERE Privilege = 'Редактор' OR Privilege = 'Создатель';

-- 5. Выбрать все вопросы из списка с индексами вопросов
SELECT *
FROM question
WHERE id_question IN (1, 4, 7);

-- 6. Выбрать все тесты, которые закончатся в указанный период
SELECT *
FROM testing
WHERE End_date BETWEEN "2023-02-24 16:00:00" AND "2024-02-27 16:00:00";

-- 7. Выбрать оплату за курсы, в которой комиссия между 0.04 и 0.06 включительно
SELECT *
FROM payment
WHERE Commission BETWEEN 0.04 AND 0.06;

-- 8. Вывести все элементы курса с отсутствующими прикреплёнными файлами
SELECT *
FROM `course element`
WHERE Attached_file IS NULL;

-- 9. Вывести все тестирования, неделю день с начала года, на которой будет
-- начинаться данное тестирование
SELECT id_test,
	   Start_date,
       EXTRACT(WEEK FROM Start_date) AS Week,
       EXTRACT(DAY FROM Start_date) AS Day
FROM testing;

-- 10. Вывести количество дней, которое пользователь не заходил на платформу,
-- если с времени его последнего доступа прошло не больше 29 дней
SELECT Login,
	   Name,
	   The_time_of_the_last_access_to_the_system,
       TIMESTAMPDIFF(DAY, The_time_of_the_last_access_to_the_system, CURRENT_TIME()) AS Delta_time
FROM user
WHERE TIMESTAMPDIFF(DAY, The_time_of_the_last_access_to_the_system, CURRENT_TIME()) <= 29;

-- 11. Выбор всех курсов с рейтингом меньше 4.5
SELECT *
FROM course
WHERE Rating < 4.5;

-- 12. Выбор всех форумов с количеством сообщений не в диапазоне от 10 до 30 включительно
SELECT *
FROM forum
WHERE NOT Number_of_messages BETWEEN 10 AND 30;

-- 13. Вывод всех результатов ответов на вопросы пользователя 3pknai
SELECT *
FROM `user to question`
WHERE User_Login = "3pknai";

-- 14. Выбрать названия вопросов, в которых значение максимального балла больше 20 баллов
SELECT Name,
	   Score_for_correct_execution AS Score
FROM question
WHERE Score_for_correct_execution > 20;

-- 15. Выбор всех уведомлений пришедших пользователям после 12 часов (во второй половине дня)
SELECT id_notification,
	   Name,
       Date_of_dispatch,
       hour(Date_of_dispatch)
FROM notification
WHERE hour(Date_of_dispatch) > 12;

-- 16. Выбор всех пользователей на платформе у которых страна в, которой они живут, встречается
-- только у одного человека на платформе
SELECT Login,
	   Country
FROM user
WHERE Country IN
(SELECT Country
FROM user
GROUP BY Country
HAVING COUNT(*) = 1);