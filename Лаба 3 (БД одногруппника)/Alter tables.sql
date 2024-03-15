-- Добавление поля количество в связь между корзиной и товаром
ALTER TABLE `basket to product` ADD count INT NOT NULL DEFAULT 1;

-- Изменение столбца таблицы (увеличение количества символов)
ALTER TABLE buyer modify email varchar(50);

ALTER TABLE moderators ADD id_administrators int;
-- Добавление внешнего ключа
ALTER TABLE moderators ADD FOREIGN KEY (id_administrators) REFERENCES administrators(id_administrators);

-- Удаление внешнего ключа
ALTER TABLE moderators DROP constraint moderators_ibfk_2;

-- Удаление первичного ключа
ALTER TABLE delivery DROP id_delivery;

-- Добавление первичного ключа
ALTER TABLE delivery ADD PRIMARY KEY (address);

-- Добавление ограничения уникальности
ALTER TABLE buyer ADD CONSTRAINT email_unq UNIQUE(email);

-- Переименование столбца таблицы
ALTER TABLE administrators RENAME COLUMN id_administrators TO id_administrator;

-- Переименование таблицы
ALTER TABLE `technical support` RENAME TO tech_support;
