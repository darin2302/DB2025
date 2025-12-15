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
INSERT INTO product (product_id, product_name, group_id, price) VALUES (6, 'Дънки Levi''s 501', 2, 129.99);
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
INSERT INTO product (product_id, product_name, group_id, price) VALUES (18, 'Шампоан L''Oreal Professional', 4, 19.99);
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
-- 3. ПОЗИЦИИ/ДЛЪЖНОСТИ
-- ============================================
INSERT INTO position (position_id, position_name) VALUES (1, 'Мениджър');
INSERT INTO position (position_id, position_name) VALUES (2, 'Продавач');
INSERT INTO position (position_id, position_name) VALUES (3, 'Старши продавач');
INSERT INTO position (position_id, position_name) VALUES (4, 'Касиер');

-- ============================================
-- 4. СЛУЖИТЕЛИ
-- ============================================
INSERT INTO employee (employee_id, employee_name, position_id, phone) VALUES (1, 'Иван Петров', 1, '+359888111222');
INSERT INTO employee (employee_id, employee_name, position_id, phone) VALUES (2, 'Мария Димитрова', 2, '+359888222333');
INSERT INTO employee (employee_id, employee_name, position_id, phone) VALUES (3, 'Георги Стоянов', 2, '+359888333444');
INSERT INTO employee (employee_id, employee_name, position_id, phone) VALUES (4, 'Елена Иванова', 3, '+359888444555');
INSERT INTO employee (employee_id, employee_name, position_id, phone) VALUES (5, 'Петър Георгиев', 4, '+359888555666');

-- ============================================
-- 5. КЛИЕНТИ
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
-- 6. ПРОДАЖБИ (заглавна информация)
-- ============================================

-- Януари 2024
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (1, 1, 2, TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (2, 2, 3, TO_DATE('2024-01-08', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (3, 3, 2, TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (4, 4, 4, TO_DATE('2024-01-12', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (5, 5, 2, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

-- Февруари 2024
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (6, 1, 3, TO_DATE('2024-02-02', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (7, 6, 4, TO_DATE('2024-02-05', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (8, 7, 2, TO_DATE('2024-02-08', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (9, 8, 3, TO_DATE('2024-02-10', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (10, 9, 5, TO_DATE('2024-02-12', 'YYYY-MM-DD'));

-- Март 2024
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (11, 2, 2, TO_DATE('2024-03-01', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (12, 3, 3, TO_DATE('2024-03-05', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (13, 10, 4, TO_DATE('2024-03-08', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (14, 4, 2, TO_DATE('2024-03-10', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (15, 5, 3, TO_DATE('2024-03-15', 'YYYY-MM-DD'));

-- Април 2024
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (16, 6, 5, TO_DATE('2024-04-02', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (17, 7, 5, TO_DATE('2024-04-03', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (18, 8, 2, TO_DATE('2024-04-05', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (19, 9, 2, TO_DATE('2024-04-08', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (20, 1, 4, TO_DATE('2024-04-10', 'YYYY-MM-DD'));

-- Май 2024
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (21, 2, 3, TO_DATE('2024-05-01', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (22, 3, 2, TO_DATE('2024-05-05', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (23, 10, 5, TO_DATE('2024-05-08', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (24, 4, 4, TO_DATE('2024-05-12', 'YYYY-MM-DD'));
INSERT INTO sale (sale_id, client_id, employee_id, sale_date) VALUES (25, 5, 3, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

-- ============================================
-- 7. АРТИКУЛИ В ПРОДАЖБИ (sale_item)
-- ============================================

-- Продажба 1: Анна купува лаптоп и мишка
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 1, 2499.99);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (2, 1, 5, 1, 99.99);

-- Продажба 2: Христо купува шоколади и вода
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (3, 2, 12, 5, 2.49);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (4, 2, 14, 2, 3.99);

-- Продажба 3: Димитър купува дрехи
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (5, 3, 6, 1, 129.99);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (6, 3, 7, 2, 45.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (7, 3, 10, 1, 24.99);

-- Продажба 4: София купува книги
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (8, 4, 21, 1, 15.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (9, 4, 22, 1, 22.00);

-- Продажба 5: Николай купува слушалки
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (10, 5, 3, 1, 399.99);

-- Продажба 6: Анна купува телефон и калъф (слушалки)
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (11, 6, 2, 1, 1899.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (12, 6, 3, 1, 399.99);

-- Продажба 7: Ваня купува козметика
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (13, 7, 16, 1, 159.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (14, 7, 17, 2, 12.99);

-- Продажба 8: Стоян купува дрехи
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (15, 8, 7, 3, 45.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (16, 8, 9, 1, 119.00);

-- Продажба 9: Радост купува спортни стоки
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (17, 9, 26, 1, 49.99);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (18, 9, 27, 1, 35.00);

-- Продажба 10: Борис купува кафе и храна
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (19, 10, 11, 2, 18.50);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (20, 10, 15, 3, 2.99);

-- Продажба 11: Христо купува велосипед
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (21, 11, 29, 1, 899.00);

-- Продажба 12: Димитър купува таблет
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (22, 12, 4, 1, 649.00);

-- Продажба 13: Кристина купува вино и шоколад
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (23, 13, 13, 2, 25.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (24, 13, 12, 3, 2.49);

-- Продажба 14: София купува книга и кафе
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (25, 14, 23, 1, 45.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (26, 14, 11, 1, 18.50);

-- Продажба 15: Николай купува яке
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (27, 15, 8, 1, 189.99);

-- Продажба 16: Ваня купува храна
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (28, 16, 12, 10, 2.49);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (29, 16, 15, 5, 2.99);

-- Продажба 17: Стоян купува храна
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (30, 17, 11, 1, 18.50);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (31, 17, 12, 4, 2.49);

-- Продажба 18: Радост купува козметика
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (32, 18, 18, 1, 19.99);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (33, 18, 19, 1, 29.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (34, 18, 20, 2, 14.50);

-- Продажба 19: Борис купува лаптоп
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (35, 19, 1, 1, 2499.99);

-- Продажба 20: Анна купува козметика
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (36, 20, 17, 1, 12.99);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (37, 20, 18, 1, 19.99);

-- Продажба 21: Христо купува спортни стоки
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (38, 21, 27, 2, 35.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (39, 21, 28, 1, 79.00);

-- Продажба 22: Димитър купува електроника
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (40, 22, 3, 1, 399.99);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (41, 22, 5, 2, 99.99);

-- Продажба 23: Кристина купува книги
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (42, 23, 24, 1, 32.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (43, 23, 25, 1, 18.00);

-- Продажба 24: София купува дрехи и обувки
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (44, 24, 6, 1, 129.99);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (45, 24, 9, 1, 119.00);

-- Продажба 25: Николай купува скейтборд и топка
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (46, 25, 30, 1, 149.00);
INSERT INTO sale_item (sale_item_id, sale_id, product_id, quantity, unit_price) VALUES (47, 25, 26, 1, 49.99);

COMMIT;

-- Проверка на въведените данни
SELECT 'Групи продукти:' AS info, COUNT(*) AS broi FROM product_group
UNION ALL
SELECT 'Продукти:', COUNT(*) FROM product
UNION ALL
SELECT 'Позиции:', COUNT(*) FROM position
UNION ALL
SELECT 'Служители:', COUNT(*) FROM employee
UNION ALL
SELECT 'Клиенти:', COUNT(*) FROM client
UNION ALL
SELECT 'Продажби:', COUNT(*) FROM sale
UNION ALL
SELECT 'Артикули в продажби:', COUNT(*) FROM sale_item;
