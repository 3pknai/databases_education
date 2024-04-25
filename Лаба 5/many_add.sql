-- Добавить данные в таблицу user
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user_data.csv'
INTO TABLE user
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Login, Name, Password, The_time_of_the_last_access_to_the_system, Mail, Date_of_birth, Telephone, Country, Avatar);

-- Добавить данные в таблицу payment
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payment_data.csv'
INTO TABLE payment
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Method, Price, Commission);

-- Добавить данные в таблицу forum
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/forum_data.csv'
INTO TABLE forum
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Number_of_messages, The_subject_of_the_question);

-- Добавить данные в таблицу content bank
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/content_bank_data.csv'
INTO TABLE `content bank`
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Access_rights, Location_on_the_server);

-- Добавить данные в таблицу course
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/course_data.csv'
INTO TABLE course
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(`Short name`, Name, Description, Duration, Rating, The_beginning_of_the_course, Payment_id_payment, Forum_id_forum, `Content bank_id_content_bank`);

-- Добавить данные в таблицу question
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/question_data.csv'
INTO TABLE question
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Name, Text, Score_for_correct_execution, Creation_time, Type, The_maximum_size_of_the_file_to_be_added, The_maximum_number_of_files_to_add);

-- Добавить данные в таблицу testing
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/testing_data.csv'
INTO TABLE testing
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Start_date, End_date, `Content bank_id_content_bank`);

-- Добавить данные в таблицу testing_to_question
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/testing_to_question_data.csv'
INTO TABLE `testing to question`
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Testing_id_test, Question_id_question, Number);

-- Добавить данные в таблицу user_to_course
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user_to_course_data.csv'
INTO TABLE `user to course`
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(`Course_Short name`, User_Login, Role);

-- Добавить данные в таблицу user_to_question
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user_to_question_data.csv'
INTO TABLE `user to question`
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Question_id_question, User_Login, The_score_received);

-- Добавить данные в таблицу course_element
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/course_element_data.csv'
INTO TABLE `course element`
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Number, Name, Type, Visibility, Attached_file, `Content bank_id_content_bank`);

-- Добавить данные в таблицу notification
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/notification_data.csv'
INTO TABLE notification
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Text, Date_of_dispatch, Name);

-- Добавить данные в таблицу blog
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/blog_data.csv'
INTO TABLE blog
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Content, Date_of_publication, Title);

-- Добавить данные в таблицу user_to_blog
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user_to_blog_data.csv'
INTO TABLE `user to blog`
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Blog_id_blog, User_Login, Privilege);

-- Добавить данные в таблицу user_to_notification
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user_to_notification_data.csv'
INTO TABLE `user to notification`
FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';'
LINES TERMINATED BY '\n'
(Notification_id_notification, User_Login, `Read`);
