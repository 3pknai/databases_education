-- 1. Перечисление всех пользователей в каждом курсе через точку с запятой
SELECT `Course_Short name` AS name,
	   GROUP_CONCAT(User_Login SEPARATOR ";") AS list_of_user
FROM `user to course`
GROUP BY `Course_Short name`;

-- 2. Перечисление всех тестирований в курсе, отсортированных по дате завершения от новых к старым
SELECT `Short name`,
	   GROUP_CONCAT(testing.id_test ORDER BY testing.End_date DESC) AS list_of_tests
FROM course
JOIN `content bank` ON `content bank`.id_content_bank = `Content bank_id_content_bank`
LEFT JOIN testing ON testing.`Content bank_id_content_bank` = `content bank`.id_content_bank
GROUP BY `Short name`
ORDER BY list_of_tests DESC;