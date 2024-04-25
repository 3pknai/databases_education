-- 1. Выбрать всех связи между блогами и пользователями, в которых пользователь
-- является или редактором или создателем
SELECT *
FROM `user to blog`
WHERE Privilege = 'Редактор' OR Privilege = 'Создатель';

CREATE INDEX idx_privilege ON `user to blog`(Privilege);
DROP INDEX idx_privilege ON `user to blog`;

-- 2. Выбрать все баллы выше 5 которые получили пользователи отвечая на вопросы типа "Короткий ответ"
EXPLAIN SELECT *
FROM `user to question`
JOIN question ON question.id_question = Question_id_question
WHERE The_score_received > 5 AND question.Type = "Короткий ответ"
LIMIT 0, 4000000;

CREATE INDEX idx_question_type ON question(Type);
DROP INDEX idx_question_type ON question;

-- 3. Выбрать всех пользователей, у которые mail начинается на букву "a"
EXPLAIN SELECT *
FROM user
WHERE mail LIKE "a%"
LIMIT 0,40000;

CREATE INDEX idx_email ON user(mail);
DROP INDEX idx_email ON user;

-- 4. Выбрать все непрочинанные уведомления
EXPLAIN SELECT *
FROM `user to notification`
WHERE `Read` = 0
LIMIT 0,4000000;

CREATE INDEX idx_read ON `user to notification`(`Read`);
DROP INDEX idx_read ON `user to notification`;

-- 5. Выбрать все скрытые элементы курсов типа "Ссылка"
EXPLAIN SELECT *
FROM `course element`
WHERE Visibility = 0
	AND Type = "Ссылка"
LIMIT 0,4000000;

CREATE INDEX idx_vis_link ON `course element`(Visibility, Type);
DROP INDEX idx_vis_link ON `course element`;