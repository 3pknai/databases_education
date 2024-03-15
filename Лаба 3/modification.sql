SELECT SUM(price) as total_salary FROM payment WHERE Commission > 0.035;

SELECT Name FROM course UNION ALL SELECT Name FROM question ORDER BY Name;

SELECT `Course_Short name`, User_Login, Name, Role FROM `user to course` INNER JOIN `user` ON User_Login = Login;
