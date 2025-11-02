-- ============================================
-- ПРОЕКТ БАЗА ДАННИ - МАГАЗИН
-- DML КОМАНДИ (Data Manipulation Language)
-- ПРИМЕРНИ ДАННИ
-- ============================================

-- ============================================
-- 1. ГРУПИ ПРОДУКТИ
-- ============================================
INSERT INTO product_group (group_id, group_name) VALUES (1, 'Електроника');
INSERT INTO product_group (group_id, group_name) VALUES (2, 'Дрехи');
INSERT INTO product_group (group_id, group_name) VALUES (3, 'Храна и напитки');
INSERT INTO product_group (group_id, group_name) VALUES (4, 'Козметика');
INSERT INTO product_group (group_id, group_name) VALUES (5, 'Книги');
INSERT INTO product_group (group_id, group_name) VALUES (6, 'Спортни стоки');

-- ============================================
-- 2. ПРОДУКТИ
-- ============================================

-- Електроника
INSERT INTO product (product_id, product_name, group_id, price) VALUES (1, 'Лаптоп Dell XPS 15', 1, 2499.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (2, 'Смартфон iPhone 14', 1, 1899.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (3, 'Слушалки Sony WH-1000XM5', 1, 399.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (4, 'Таблет Samsung Galaxy Tab', 1, 649.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (5, 'Мишка Logitech MX Master', 1, 99.99);

-- Дрехи
INSERT INTO product (product_id, product_name, group_id, price) VALUES (6, 'Дънки Levi\'s 501', 2, 129.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (7, 'Тениска Nike Sportswear', 2, 45.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (8, 'Яке Adidas Original', 2, 189.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (9, 'Обувки Puma Running', 2, 119.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (10, 'Чорапи Calvin Klein (3бр)', 2, 24.99);

-- Храна и напитки
INSERT INTO product (product_id, product_name, group_id, price) VALUES (11, 'Кафе Lavazza 1кг', 3, 18.50);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (12, 'Шоколад Milka 100г', 3, 2.49);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (13, 'Вино Mavrud Reserve', 3, 25.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (14, 'Минерална вода Bankya 6л', 3, 3.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (15, 'Паста Barilla 500г', 3, 2.99);

-- Козметика
INSERT INTO product (product_id, product_name, group_id, price) VALUES (16, 'Парфюм Chanel No.5', 4, 159.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (17, 'Крем Nivea Anti-Age', 4, 12.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (18, 'Шампоан L\'Oreal Professional', 4, 19.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (19, 'Червило MAC Ruby Woo', 4, 29.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (20, 'Лак за нокти OPI', 4, 14.50);

-- Книги
INSERT INTO product (product_id, product_name, group_id, price) VALUES (21, 'Под игото - Иван Вазов', 5, 15.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (22, 'Harry Potter - Философски камък', 5, 22.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (23, 'Программиране с Python', 5, 45.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (24, 'Готварска книга', 5, 32.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (25, '1984 - George Orwell', 5, 18.00);

-- Спортни стоки
INSERT INTO product (product_id, product_name, group_id, price) VALUES (26, 'Футболна топка Nike Strike', 6, 49.99);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (27, 'Йога постелка Reebok', 6, 35.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (28, 'Хантели 10кг комплект', 6, 79.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (29, 'Велосипед Trek Mountain', 6, 899.00);
INSERT INTO product (product_id, product_name, group_id, price) VALUES (30, 'Скейтборд Element', 6, 149.00);

-- ============================================
-- 3. СЛУЖИТЕЛИ
-- ============================================
INSERT INTO employee (employee_id, employee_name, position, phone) VALUES (1, 'Иван Петров', 'Мениджър', '+359888111222');
INSERT INTO employee (employee_id, employee_name, position, phone) VALUES (2, 'Мария Димитрова', 'Продавач', '+359888222333');
INSERT INTO employee (employee_id, employee_name, position, phone) VALUES (3, 'Георги Стоянов', 'Продавач', '+359888333444');
INSERT INTO employee (employee_id, employee_name, position, phone) VALUES (4, 'Елена Иванова', 'Старши продавач', '+359888444555');
INSERT INTO employee (employee_id, employee_name, position, phone) VALUES (5, 'Петър Георгиев', 'Касиер', '+359888555666');

-- ============================================
-- 4. КЛИЕНТИ
-- ============================================
INSERT INTO client (client_id, client_name, phone) VALUES (1, 'Анна Николова', '+359887111000');
INSERT INTO client (client_id, client_name, phone) VALUES (2, 'Христо Василев', '+359887222000');
INSERT INTO client (client_id, client_name, phone) VALUES (3, 'Димитър Тодоров', '+359887333000');
INSERT INTO client (client_id, client_name, phone) VALUES (4, 'София Атанасова', '+359887444000');
INSERT INTO client (client_id, client_name, phone) VALUES (5, 'Николай Костов', '+359887555000');
INSERT INTO client (client_id, client_name, phone) VALUES (6, 'Ваня Христова', '+359887666000');
INSERT INTO client (client_id, client_name, phone) VALUES (7, 'Стоян Иванов', '+359887777000');
INSERT INTO client (client_id, client_name, phone) VALUES (8, 'Радост Петкова', '+359887888000');
INSERT INTO client (client_id, client_name, phone) VALUES (9, 'Борис Маринов', '+359887999000');
INSERT INTO client (client_id, client_name, phone) VALUES (10, 'Кристина Димитрова', '+359887000111');

-- ============================================
-- 5. ПРОДАЖБИ
-- ============================================

-- Продажби Януари 2024
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (1, 1, 1, 2, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 2499.99);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (2, 12, 2, 3, TO_DATE('2024-01-08', 'YYYY-MM-DD'), 2.49);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (3, 6, 3, 2, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 129.99);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (4, 21, 4, 4, TO_DATE('2024-01-12', 'YYYY-MM-DD'), 15.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (5, 3, 5, 2, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 399.99);

-- Продажби Февруари 2024
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (6, 2, 1, 3, TO_DATE('2024-02-02', 'YYYY-MM-DD'), 1899.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (7, 16, 6, 4, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 159.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (8, 7, 7, 2, TO_DATE('2024-02-08', 'YYYY-MM-DD'), 45.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (9, 26, 8, 3, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 49.99);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (10, 11, 9, 5, TO_DATE('2024-02-12', 'YYYY-MM-DD'), 18.50);

-- Продажби Март 2024
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (11, 29, 2, 2, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 899.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (12, 4, 3, 3, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 649.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (13, 13, 10, 4, TO_DATE('2024-03-08', 'YYYY-MM-DD'), 25.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (14, 22, 4, 2, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 22.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (15, 8, 5, 3, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 189.99);

-- Продажби Април 2024
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (16, 12, 6, 5, TO_DATE('2024-04-02', 'YYYY-MM-DD'), 2.49);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (17, 12, 7, 5, TO_DATE('2024-04-03', 'YYYY-MM-DD'), 2.49);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (18, 12, 8, 2, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 2.49);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (19, 1, 9, 2, TO_DATE('2024-04-08', 'YYYY-MM-DD'), 2499.99);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (20, 17, 1, 4, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 12.99);

-- Продажби Май 2024
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (21, 27, 2, 3, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 35.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (22, 3, 3, 2, TO_DATE('2024-05-05', 'YYYY-MM-DD'), 399.99);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (23, 11, 10, 5, TO_DATE('2024-05-08', 'YYYY-MM-DD'), 18.50);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (24, 23, 4, 4, TO_DATE('2024-05-12', 'YYYY-MM-DD'), 45.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (25, 9, 5, 3, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 119.00);

-- Допълнителни продажби за по-реалистична статистика
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (26, 12, 1, 2, TO_DATE('2024-05-16', 'YYYY-MM-DD'), 2.49);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (27, 12, 2, 3, TO_DATE('2024-05-17', 'YYYY-MM-DD'), 2.49);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (28, 11, 6, 5, TO_DATE('2024-05-18', 'YYYY-MM-DD'), 18.50);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (29, 2, 7, 2, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 1899.00);
INSERT INTO sale (sale_id, product_id, client_id, employee_id, sale_date, sale_price) VALUES (30, 18, 8, 4, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 19.99);

COMMIT;

-- Проверка на въведените данни
SELECT 'Групи продукти:' AS info, COUNT(*) AS broi FROM product_group
UNION ALL
SELECT 'Продукти:', COUNT(*) FROM product
UNION ALL
SELECT 'Служители:', COUNT(*) FROM employee
UNION ALL
SELECT 'Клиенти:', COUNT(*) FROM client
UNION ALL
SELECT 'Продажби:', COUNT(*) FROM sale;

