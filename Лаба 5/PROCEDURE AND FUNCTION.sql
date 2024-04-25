SET GLOBAL log_bin_trust_function_creators = 1;

-- 1. Расчитать возраст пользователя 
DELIMITER $$
CREATE FUNCTION get_user_age(date_of_birth date)
RETURNS INT
BEGIN
    DECLARE age_user INT;
    SET age_user = TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_DATE);
    RETURN age_user;
END $$
DELIMITER ;

SELECT Login,
	   Date_of_birth,
       Mail,
	   get_user_age(Date_of_birth) as age
FROM user;

-- 2. Вывод рейтинга курса (если рейтинг >= 0.475, то вывести "высокий",
-- если рейтинг >= 0.45, то вывести "средний", иначе - "низкий")
DELIMITER $$
CREATE FUNCTION get_rang(rating FLOAT)
RETURNS VARCHAR(50)
BEGIN
    DECLARE rang VARCHAR(50);
    SET rang = IF(rating >= 0.475, "высокий", IF(rating >= 0.45, "средний", "низкий"));
    RETURN rang;
END $$
DELIMITER ;

SELECT `Short name`,
	   Rating,
       Duration,
	   get_rang(Rating) as StringRating
FROM course;

-- 3. Вывод доступности через видимость элемента
DELIMITER $$
CREATE FUNCTION get_visibility(vis int)
RETURNS VARCHAR(50)
BEGIN
    DECLARE visible VARCHAR(50);
    set visible = CASE vis
		WHEN 0 THEN "Скрытый"
		WHEN 1 THEN "Открытый"
	END;
    RETURN visible;
END $$
DELIMITER ;

SELECT id_course_element,
	   Number,
       Type,
       Visibility,
	   get_visibility(Visibility) as StringVisibility
FROM `course element`;

-- 4. Вывести цену самого дорогого курса на платформе
DELIMITER $$
CREATE PROCEDURE GetMaxPrice()
BEGIN
    SELECT course.Name,
	   payment.Price
	FROM course
	JOIN payment ON payment.id_payment = course.Payment_id_payment
	WHERE payment.Price = (SELECT MAX(Price) FROM payment);
END $$
DELIMITER ;

CALL GetMaxPrice();
 
-- 5. Выбор всех имён пользоветелей с почтой, у которых почта удовлетворяет шаблону
DELIMITER $$
CREATE PROCEDURE GetMail(shablon VARCHAR(50))
BEGIN
    SELECT Name,
	   mail
	FROM user
	WHERE mail LIKE shablon;
END $$
DELIMITER ;

CALL GetMail("a%gmail.com");

-- 6. Вывод часа, дня, недели окончания каждого тестирования
DELIMITER $$
CREATE PROCEDURE GetTestingEndInfo()
BEGIN
    SELECT id_test, HOUR(End_date) AS hour, DAY(End_date) AS day, WEEK(End_date) AS week
	FROM testing;
END $$
DELIMITER ;

CALL GetTestingEndInfo();

-- 7. Вывод суммарной стоимости какого-то количества курсов, отсортированных по рейтингу
DELIMITER $$
CREATE PROCEDURE course_price(lim INT)
BEGIN
    DECLARE summa, summ, counter INT;
    set summa = 0;
    set counter = 0;
    label: LOOP
		IF counter = lim THEN
			LEAVE label;
		END IF;
        
		SELECT payment.price FROM course
        JOIN payment ON payment.id_payment = course.Payment_id_payment
		ORDER BY Rating DESC
		LIMIT 1 OFFSET counter INTO summ;
        
        SET summa = summa + summ;
		SET counter = counter + 1;
		
	END LOOP label;
    SELECT summa;
END $$
DELIMITER ;

CALL course_price(6);


-- 8. Вывести все элементы указанного курса в порядке их следования в курсе (вместо
-- NULL в прикреплённых файлах выводить "N/A")
DELIMITER $$
CREATE PROCEDURE course_elements(course_short_name VARCHAR(50))
BEGIN
	DECLARE id_content_bank INT;
    
    SELECT `Content bank_id_content_bank`
    FROM course
    WHERE course_short_name = `Short name`
    INTO id_content_bank;
    
    SELECT Number, Name, Type, Visibility, IFNULL(Attached_file, 'N/A') AS File
    FROM `course element`
    WHERE `Content bank_id_content_bank` = id_content_bank
    ORDER BY Number;
    
END $$
DELIMITER ;

CALL course_elements("ai-1-s");