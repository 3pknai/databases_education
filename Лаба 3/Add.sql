-- Forum
INSERT forum(id_forum, Number_of_messages, The_subject_of_the_question) 
VALUES
(1, 14, 'Как сделать коммит?'),
(2, 28, "Как связать удаленный репозиторий?"),
(3, 24, "Как сделать выбор данных по критерию?"),
(4, 12, "Как объединить данные из разных таблиц?"),
(5, 7, "Как добавить новую лекцию в курс?"),
(6, 33, "Как настроить автоматическую проверку кода?"),
(7, 15, "Как настроить доступ к видеолекциям?"),
(8, 16, "Как создать сертификат?"),
(9, 16, "Как отслеживать прогресс студентов?"),
(10, 20, "Как добавить новую главу в учебник?");

-- User
INSERT user(Login, Name, Password, Telephone, Mail, Country, Avatar, The_time_of_the_last_access_to_the_system, Date_of_birth) 
VALUES
("3pknai", "Боков С.Д.", "Пупупу", "79665115211", "slavabokov2004@mail.ru", "Russia", "/files/3pknai.img", '2024-02-27 08:15', '1998-02-15'),
('mary234', 'Johnson, Mary', 'pass123', '555-1234', 'mary234@email.com', 'USA', '/files/mary234.img', '2024-02-28 09:30', '1990-06-12'),
('jdoe78', 'Doe, John', 'password1', '555-5678', 'jdoe78@gmail.com', 'Canada', '/files/jdoe78.img', '2024-02-28 15:45', '1978-03-08'),
('alex87', 'Smith, Alex', 'mysecret123', '555-9876', 'alex87@hotmail.com', 'UK', '/files/alex87.img', '2024-02-27 10:20', '1987-09-20'),
('saraB84', 'Brown, Sara', 'ilovecats12', '555-8888', 'saraB84@yahoo.com', 'Australia', '/files/saraB84.img', '2024-02-26 16:55', '1984-07-10'),
('jchung32', 'Chung, Jane', 'hello1234', '555-4567', 'jchung32@gmail.com', 'South Korea', '/files/jchung32.img', '2024-02-27 08:15', '1998-02-15'),
('mario92', 'Rossi, Mario', 'ciao9876', '555-1111', 'mario92@email.com', 'Italy', '/files/mario92.img', '2024-02-28 11:10', '1992-09-18'),
('nicole39', 'Williams, Nicole', 'nicolepwrd', '555-2222', 'nicole39@gmail.com', 'USA', '/files/nicole39.img', '2024-02-28 17:25', '1981-12-05'),
('rharper75', 'Harper, Ryan', 'qwerty12345', '555-3333', 'rharper75@hotmail.com', 'Canada', '/files/rharper75.img', '2024-02-27 14:50', '1975-05-20'),
('paulo88', 'Silva, Paulo', 'paulopass', '555-4444', 'paulo88@yahoo.com', 'Brazil', '/files/paulo88.img', '2024-02-26 19:05', '1988-11-07'),
('lisa01', 'Johnson, Lisa', 'lisa123!', '555-5555', 'lisa01@gmail.com', 'USA', '/files/lisa01.img', '2024-02-28 20:30', '2001-04-15');

-- Payment
INSERT payment (id_payment, Method, Price, Commission)
VALUES 
(1, 'Через платформу', 7000, 0),
(2, 'Через платформу', 9000, 0),
(3, 'Через платформу', 12000, 0),
(4, 'Перевод по СБП', 8000, 0.05),
(5, 'Перевод по СБП', 12500, 0.07),
(6, 'Перевод по СБП', 13000, 0.03),
(7, 'Перевод по Сберу', 7700, 0.035),
(8, 'Перевод по Сберу', 10000, 0.045),
(9, 'Перевод по Сберу', 13000, 0.04),
(10, 'Перевод по Сберу', 14000, 0.01);

-- Blog
INSERT blog (id_blog, Title, Content, Date_of_publication)
VALUES 
(1, 'Как правильно выбрать тренера по фитнесу', 'Советы по выбору тренера, который поможет вам достичь ваших фитнес-целей', '2022-10-01'),
(2, 'Топ 10 рецептов здоровых завтраков', 'Идеи и рецепты для приготовления питательных и вкусных завтраков', '2022-11-15'),
(3, 'Как развить свои навыки публичных выступлений', 'Полезные советы и упражнения для повышения уверенности на публичных выступлениях', '2023-01-05'),
(4, 'Лучшие способы управления своим временем', 'Практические советы и стратегии, чтобы эффективно использовать свое время', '2023-02-20'),
(5, 'Основы программирования: введение в Python', 'Краткое руководство по началу программирования на языке Python', '2023-03-10'),
(6, 'Как стать успешным предпринимателем', 'Советы и лайфхаки для развития бизнеса и достижения успеха в предпринимательской сфере', '2023-04-25'),
(7, 'Путешествие по Италии: лучшие города', 'Гид по самым интересным местам для посещения в Италии', '2023-06-01'),
(8, 'Техники улучшения фотографии', 'Советы по обработке фотографий и созданию качественных изображений', '2023-08-15'),
(9, 'Основы финансового планирования', 'Как правильно управлять своими финансами и планировать будущее', '2023-09-02'),
(10, 'Тайны медитации: путь к внутреннему покою', 'Основы и практика медитации для достижения умиротворенного состояния', '2023-10-20');

-- Content bank
INSERT `content bank` (id_content_bank, Access_rights, Location_on_the_server)
VALUES  
(1, 'Общедоступный', '/courses/bank1'),
(2, 'Закрытый', '/courses/bank2'),
(3, 'Частичнодоступный', '/courses/bank3'),
(4, 'Общедоступный', '/courses/bank4'),
(5, 'Закрытый', '/courses/bank5'),
(6, 'Частичнодоступный', '/courses/bank6'),
(7, 'Общедоступный', '/courses/bank7'),
(8, 'Закрытый', '/courses/bank8'),
(9, 'Частичнодоступный', '/courses/bank9'),
(10, 'Общедоступный', '/courses/bank10');

-- Course
INSERT Course (`Short name`, Name, The_beginning_of_the_course, Duration, Description, Rating, Forum_id_forum, Payment_id_payment, `Content bank_id_content_bank`)
VALUES
('web101', 'Web Development 101', '2022-10-01', 30, 'An introductory course on web development covering HTML, CSS, and JavaScript.', 4.5, 1, 1, 1),
('python201', 'Python Programming 201', '2022-11-15', 45, 'An intermediate course on Python programming covering advanced topics such as object-oriented programming and data structures.', 4.2, 2, 2, 2),
('java101', 'Introduction to Java Programming', '2023-01-05', 60, 'A beginner-level course on Java programming for those who want to learn the basics of Java.', 4.7, 3, 3, 3),
('dbms202', 'Database Management Systems 202', '2023-02-20', 50, 'An advanced course on database management systems covering topics like normalization, indexing, and transactions.', 4.3, 4, 4, 4),
('ml101', 'Machine Learning 101', '2023-03-10', 30, 'An introductory course on machine learning covering the basics of supervised and unsupervised learning algorithms.', 4.6, 5, 5, 5),
('cybersec201', 'Cybersecurity 201', '2023-04-25', 45, 'An intermediate-level course on cybersecurity covering concepts like network security, ethical hacking, and information protection.', 4.4, 6, 6, 6),
('frontend202', 'Advanced Frontend Development', '2023-06-01', 60, 'An advanced course on frontend development focusing on advanced CSS frameworks, JavaScript libraries, and responsive design.', 4.8, 7, 7, 7),
('backend202', 'Advanced Backend Development', '2023-08-15', 45, 'An advanced course on backend development covering topics such as API development, database integration, and server management.', 4.7, 8, 8, 8),
('ios101', 'iOS App Development 101', '2023-09-02', 30, 'An introductory course on iOS app development covering Swift programming language and basics of iOS app development.', 4.3, 9, 9, 9),
('datasci101', 'Introduction to Data Science', '2023-10-20', 60, 'An introductory course on data science covering data preprocessing, exploratory data analysis, and basic statistical concepts.', 4.5, 10, 10, 10);

-- Notification
INSERT notification (id_notification, Name, Text, Date_of_dispatch)
VALUES 
(1, 'Обновление информации', 'В ближайшее время будет проведено обновление информации на нашей платформе. Просим держать вас в курсе изменений.', '2023-05-15 10:30'),
(2, 'Важное обновление', 'Планируется важное обновление платформы. Проходите тестирование, чтобы быть готовыми к изменениям.', '2023-03-10 14:00'),
(3, 'Расширение функционала', 'Мы рады сообщить, что мы расширяем функционал нашей платформы. Скоро будут доступны новые возможности.', '2023-09-20 09:45'),
(4, 'Технические работы', 'В связи с проведением технических работ возможны временные перебои в работе платформы. Просим прощения за неудобства.', '2023-07-05 17:30'),
(5, 'Изменения в интерфейсе', 'Мы обновили интерфейс платформы для улучшения пользовательского опыта. Оцените новые изменения.', '2023-02-28 08:15'),
(6, 'Внимание кражи данных', 'Обратите внимание на безопасность своих данных. Будьте осторожны с личной информацией и паролями.', '2023-10-12 11:20'),
(7, 'Новые обучающие материалы', 'Мы добавили новые обучающие материалы на платформу. Изучайте новые темы и совершенствуйте свои навыки.', '2023-04-02 16:45'),
(8, 'Техническая поддержка', 'Наша техническая поддержка работает круглосуточно. Обратитесь к нам в случае возникновения проблем.', '2023-06-18 13:10'),
(9, 'Обновление программы курса', 'Программа курса была обновлена. Ознакомьтесь с новыми темами и заданиями.', '2023-08-30 10:00'),
(10, 'Получите сертификат', 'Завершите курс и получите сертификат о прохождении. Успейте закончить все задания.', '2023-11-25 15:30');

-- Question
INSERT INTO question (id_question, Name, Type, Creation_time, Text, Score_for_correct_execution, The_maximum_size_of_the_file_to_be_added, The_maximum_number_of_files_to_add)
VALUES 
(1, 'ДЗ-8 вопрос № 1', 'Выбор из списка', '2023-02-15 18:15', 'Расположите процесс преобразование сложной модели в более простую', 12.50, 0, 0),
(2, 'ДЗ-5 вопрос № 1', 'Эссе', '2023-02-16 18:15', 'Напишите реферат на тему "История создания Интернета"', 35.00, 20, 1),
(3, 'КР-2 вопрос № 3', 'Программа', '2023-02-17 18:15', 'Напишите программу на языке программирования Кумир, которая позволяет передвинуть Робота из левого нижнего угла обстановки в правый верхний при условии отсутствия внутренних стен обстановки', 20.00, 0, 0),
(4, 'ДЗ-8 вопрос № 1', 'Выбор из списка', '2023-02-18 18:15', 'Расположите процесс преобразование сложной модели в более простую', 12.50, 0, 0),
(5, 'ДЗ-5 вопрос № 1', 'Эссе', '2023-02-19 18:15', 'Напишите реферат на тему "История создания Интернета"', 35.00, 20, 1),
(6, 'КР-2 вопрос № 3', 'Программа', '2023-02-20 18:15', 'Напишите программу на языке программирования Кумир, которая позволяет передвинуть Робота из левого нижнего угла обстановки в правый верхний при условии отсутствия внутренних стен обстановки', 20.00, 0, 0),
(7, 'ДЗ-8 вопрос № 1', 'Выбор из списка', '2023-02-21 18:15', 'Расположите процесс преобразование сложной модели в более простую', 12.50, 0, 0),
(8, 'ДЗ-5 вопрос № 1', 'Эссе', '2023-02-22 18:15', 'Напишите реферат на тему "История создания Интернета"', 35.00, 20, 1),
(9, 'КР-2 вопрос № 3', 'Программа', '2023-02-23 18:15', 'Напишите программу на языке программирования Кумир, которая позволяет передвинуть Робота из левого нижнего угла обстановки в правый верхний при условии отсутствия внутренних стен обстановки', 20.00, 0, 0),
(10, 'ДЗ-8 вопрос № 1', 'Выбор из списка', '2023-02-24 18:15', 'Расположите процесс преобразование сложной модели в более простую', 12.50, 0, 0);

-- Testing
INSERT testing (id_test, Start_date, End_date, `Content bank_id_content_bank`)
VALUES 
(1, '2024-02-15 12:55', '2024-02-19 18:00', 1),
(2, '2024-02-16 12:55', '2024-02-21 12:55', 1),
(3, '2024-02-17 12:55', '2024-02-22 12:55', 2),
(4, '2024-02-18 12:55', '2024-02-23 12:55', 1),
(5, '2024-02-19 12:55', '2024-02-24 18:00', 1),
(6, '2024-02-20 12:55', '2024-02-25 12:55', 3),
(7, '2024-02-21 12:55', '2024-04-26 12:55', 1),
(8, '2024-02-22 12:55', '2024-02-27 12:55', 2),
(9, '2024-02-23 12:55', '2024-05-28 18:00', 1),
(10, '2024-02-24 12:55', '2024-03-01 12:55', 1);

-- Cource element
INSERT `course element` (id_course_element, Number, Name, Type, Visibility, Attached_file, `Content bank_id_content_bank`)
VALUES 
(1, 1, 'Посещаемость занятий', 'Отметка посещаемости', 1, NULL, 1),
(2, 2, 'Ссылка на главный архив', 'Ссылка', 1, NULL, 3),
(3, 1, 'Задание на первую практику', 'Задание', 0, '/files/practice.pdf', 2),
(4, 3, 'Пример протокола первой лабы', 'Файл', 1, '/files/protocol.docx', 3),
(5, 2, 'Анкета о качестве обучения', 'Анкетирование', 0, NULL, 2),
(6, 1, 'Видеолекции по предмету', 'Папка', 1, '/files/lecture', 3),
(7, 1, 'Тест по теме', 'Тест', 1, NULL, 4),
(8, 2, 'Результаты контрольной работы', 'Файл', 0, '/files/exam_results.docx', 1),
(9, 4, 'Итоговое задание', 'Задание', 1, NULL, 3),
(10, 3, 'Форум обсуждений', 'Форум', 1, NULL, 2);

-- Testing to Question
INSERT `testing to question` (Question_id_question, Testing_id_test, Number)
VALUES 
(1, 1, 2),
(2, 1, 1),
(3, 2, 1),
(3, 4, 2),
(4, 3, 2),
(5, 3, 1),
(6, 2, 2),
(6, 4, 1),
(7, 1, 4),
(8, 1, 3);

-- User to course
INSERT `user to course` (User_Login, `Course_Short name`, Role)
VALUES 
('3pknai', 'python201', 'Преподаватель'),
('3pknai', 'frontend202', 'Ученик'),
('jdoe78', 'backend202', 'Ученик'),
('jdoe78', 'python201', 'Ученик'),
('lisa01', 'frontend202', 'Преподаватель'),
('jdoe78', 'frontend202', 'Преподаватель'),
('lisa01', 'python201', 'Преподаватель'),
('mario92', 'backend202', 'Ученик'),
('mario92', 'python201', 'Преподаватель'),
('mario92', 'frontend202', 'Ученик');

-- User to blog
INSERT `user to blog` (User_Login, Blog_id_blog, Privilege)
VALUES 
('3pknai', 2, 'Создатель'),
('3pknai', 1, 'Редактор'),
('lisa01', 2, 'Редактор'),
('lisa01', 3, 'Читатель'),
('mario92', 1, 'Читатель'),
('mario92', 3, 'Читатель'),
('mario92', 2, 'Читатель'),
('alex87', 1, 'Редактор'),
('alex87', 3, 'Редактор'),
('rharper75', 1, 'Читатель');

-- User to notification
INSERT `user to notification` (User_Login, Notification_id_notification, `Read`)
VALUES 
('lisa01', 1, 0),
('3pknai', 1, 0),
('lisa01', 2, 1),
('mario92', 2, 0),
('mario92', 1, 1),
('alex87', 2, 0),
('alex87', 3, 1),
('rharper75', 1, 0),
('rharper75', 2, 1),
('saraB84', 3, 0);

-- User to Question
INSERT `user to question` (Question_id_question, User_Login, The_score_received)
VALUES 
(1, 'lisa01', 12.50),
(3, 'lisa01', 20.00),
(1, '3pknai', 12.50),
(2, '3pknai', 35.00),
(3, '3pknai', 19.00),
(4, 'alex87', 12.00),
(5, 'alex87', 17.50),
(1, 'rharper75', 12.50),
(2, 'rharper75', 30.00),
(3, 'rharper75', 18.00);