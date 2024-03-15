-- Site
INSERT site(id_site, name, url)
VALUES
(1, "distriction", "distriction.ru");

-- Technical support
INSERT `technical support`(id_tech_support, FIO, access_rights, id_site)
VALUES
(1, "Матохин Илья Георгиевич", "Полный", 1);

-- Administrators
INSERT administrators(id_administrators, FIO, access_rights, id_site)
VALUES
(1, "Зенин Максим Александрович", "Полный", 1);

-- Moderators
INSERT moderators(id_moderator, FIO, access_rights, id_site)
VALUES
(1, "Боков Святослав Дмитриевич", "Частичный", 1);

-- Seller
INSERT seller(id_seller, contact_information, id_site, id_tech_support)
VALUES
(1, "superpetya.ru", 1, 1);

-- Product
INSERT product(id_product, comments, quantity_in_stock, name, id_seller, id_moderator)
VALUES
(1, "Лучшая мягкая игрушка в мире!", 7, "Мышь", 1, 1),
(2, "Лучшая мягкая игрушка на свете!", 4, "Дракон", 1, 1);

-- Buyer
INSERT buyer(id_buyer, FIO, email, id_site, id_tech_support)
VALUES
(1, "Молчанова Лиана Евгеньевна", "lihimiko.mail.ru", 1, 1);

-- Review
INSERT review(id_review, text, rating, id_buyer, id_product)
VALUES
(1, "Товар пришёл в ценности", 5, 1, 1);

-- Basket
INSERT basket(id_basket, capacity, id_buyer)
VALUES
(1, 5, 1);

-- Basket to product
INSERT `basket to product`(id_basket, id_product)
VALUES
(1, 1),
(1, 2);

-- Order
INSERT `order`(id_order, order_date, id_basket)
VALUES
(1, "2024-02-15 12:00", 1);

-- Stock
INSERT stock(id_stock, address, capacity, id_order)
VALUES
(1, "ул. Н. Отрады 10а", 500, 1);

-- Delivery
INSERT delivery(id_delivery, address, date, id_stock, id_buyer)
VALUES
(1, "ул. Н. Отрады 22 173", "2024-02-16", 1, 1);