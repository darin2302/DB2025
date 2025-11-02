-- ============================================
-- ПРОЕКТ БАЗА ДАННИ - МАГАЗИН
-- SQL ЗАЯВКИ ЗА СПРАВКИ
-- ============================================

-- ============================================
-- ЧАСТ 1: ВЪВЕЖДАНЕ И КОРЕКЦИИ НА ДАННИ
-- ============================================

-- 1.1 Добавяне на нов продукт
INSERT INTO product (product_id, product_name, group_id, price) 
VALUES (31, 'Клавиатура Corsair K95', 1, 199.99);

-- 1.2 Корекция на цена на продукт
UPDATE product 
SET price = 2399.99 
WHERE product_id = 1;

-- 1.3 Добавяне на нов клиент
INSERT INTO client (client_id, client_name, phone) 
VALUES (11, 'Иван Ангелов', '+359887111222');

-- 1.4 Корекция на телефон на служител
UPDATE employee 
SET phone = '+359888111333' 
WHERE employee_id = 1;

-- 1.5 Изтриване на продукт (ако няма продажби)
-- DELETE FROM product WHERE product_id = 31;

COMMIT;

-- ============================================
-- ЧАСТ 2: ТЪРСЕНЕ НА ПРОДУКТИ
-- ============================================

-- 2.1 Търсене по цена (продукти под 50 лв)
SELECT product_id, product_name, price, 
       (SELECT group_name FROM product_group WHERE group_id = p.group_id) AS grupa
FROM product p
WHERE price < 50
ORDER BY price ASC;

-- 2.2 Търсене по цена в диапазон (между 100 и 500 лв)
SELECT product_id, product_name, price,
       (SELECT group_name FROM product_group WHERE group_id = p.group_id) AS grupa
FROM product p
WHERE price BETWEEN 100 AND 500
ORDER BY price ASC;

-- 2.3 Търсене по наименование (съдържа "Nike")
SELECT product_id, product_name, price,
       (SELECT group_name FROM product_group WHERE group_id = p.group_id) AS grupa
FROM product p
WHERE UPPER(product_name) LIKE UPPER('%Nike%')
ORDER BY product_name;

-- 2.4 Търсене по група (всички продукти от група "Електроника")
SELECT p.product_id, p.product_name, p.price
FROM product p
JOIN product_group pg ON p.group_id = pg.group_id
WHERE pg.group_name = 'Електроника'
ORDER BY p.price DESC;

-- 2.5 Търсене по група с ID
SELECT product_id, product_name, price
FROM product
WHERE group_id = 1
ORDER BY price DESC;

-- ============================================
-- ЧАСТ 3: СПРАВКИ ЗА ПРОДАЖБИ
-- ============================================

-- 3.1 ПРОДАЖБИ ЗА ПЕРИОД (Януари - Март 2024)
SELECT 
    s.sale_id AS "ID Продажба",
    s.sale_date AS "Дата",
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    c.client_name AS "Клиент",
    e.employee_name AS "Служител",
    s.sale_price AS "Цена"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-03-31', 'YYYY-MM-DD')
ORDER BY s.sale_date ASC;

-- 3.2 ПРОДАЖБИ ЗА СЛУЖИТЕЛ, ПОДРЕДЕНИ ПО ДАТА
-- Служител: Мария Димитрова (employee_id = 2)
SELECT 
    s.sale_id AS "ID Продажба",
    s.sale_date AS "Дата",
    p.product_name AS "Продукт",
    c.client_name AS "Клиент",
    s.sale_price AS "Цена"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN client c ON s.client_id = c.client_id
WHERE s.employee_id = 2
ORDER BY s.sale_date ASC;

-- 3.3 ПРОДАЖБИ ЗА СЛУЖИТЕЛ С ИМЕ
SELECT 
    e.employee_name AS "Служител",
    s.sale_date AS "Дата",
    p.product_name AS "Продукт",
    c.client_name AS "Клиент",
    s.sale_price AS "Цена"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
WHERE e.employee_name = 'Мария Димитрова'
ORDER BY s.sale_date ASC;

-- 3.4 ПРОДАЖБИ ЗА КЛИЕНТ
-- Клиент: Анна Николова (client_id = 1)
SELECT 
    c.client_name AS "Клиент",
    c.phone AS "Телефон",
    s.sale_date AS "Дата",
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    e.employee_name AS "Обслужил",
    s.sale_price AS "Цена"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
WHERE s.client_id = 1
ORDER BY s.sale_date DESC;

-- 3.5 ПРОДАЖБИ ЗА КЛИЕНТ С ИМЕ
SELECT 
    c.client_name AS "Клиент",
    s.sale_date AS "Дата",
    p.product_name AS "Продукт",
    s.sale_price AS "Цена"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN client c ON s.client_id = c.client_id
WHERE c.client_name = 'Анна Николова'
ORDER BY s.sale_date DESC;

-- ============================================
-- ЧАСТ 4: ОБОРОТ И БРОЙ ПРОДАЖБИ ПО ГРУПА
-- ============================================

-- 4.1 ОБОРОТ И БРОЙ ПРОДАЖБИ ПО ГРУПА ЗА ПЕРИОД (Цяла 2024)
SELECT 
    pg.group_name AS "Група",
    COUNT(s.sale_id) AS "Брой продажби",
    SUM(s.sale_price) AS "Общ оборот (лв)",
    ROUND(AVG(s.sale_price), 2) AS "Средна цена (лв)"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
GROUP BY pg.group_name
ORDER BY SUM(s.sale_price) DESC;

-- 4.2 ОБОРОТ И БРОЙ ПРОДАЖБИ ПО ГРУПА ЗА Q1 2024
SELECT 
    pg.group_name AS "Група",
    COUNT(s.sale_id) AS "Брой продажби",
    SUM(s.sale_price) AS "Общ оборот (лв)",
    ROUND(AVG(s.sale_price), 2) AS "Средна цена (лв)",
    ROUND(SUM(s.sale_price) * 100.0 / (SELECT SUM(sale_price) FROM sale 
                                        WHERE sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                                                           AND TO_DATE('2024-03-31', 'YYYY-MM-DD')), 2) AS "Процент от оборота (%)"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-03-31', 'YYYY-MM-DD')
GROUP BY pg.group_name
ORDER BY SUM(s.sale_price) DESC;

-- ============================================
-- ЧАСТ 5: ТОП ПРОДУКТИ ПО ОБОРОТ
-- ============================================

-- 5.1 ТОП 10 ПРОДУКТИ ПО ОБОРОТ ЗА ПЕРИОД (Цяла 2024)
SELECT 
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    COUNT(s.sale_id) AS "Брой продажби",
    SUM(s.sale_price) AS "Общ оборот (лв)",
    ROUND(AVG(s.sale_price), 2) AS "Средна цена (лв)"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
GROUP BY p.product_name, pg.group_name
ORDER BY SUM(s.sale_price) DESC
FETCH FIRST 10 ROWS ONLY;

-- 5.2 ТОП 5 ПРОДУКТИ ПО ОБОРОТ ЗА Q2 2024
SELECT 
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    COUNT(s.sale_id) AS "Брой продажби",
    SUM(s.sale_price) AS "Общ оборот (лв)"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-04-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-06-30', 'YYYY-MM-DD')
GROUP BY p.product_name, pg.group_name
ORDER BY SUM(s.sale_price) DESC
FETCH FIRST 5 ROWS ONLY;

-- 5.3 ТОП 10 ПРОДУКТИ ПО БРОЙ ПРОДАЖБИ
SELECT 
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    COUNT(s.sale_id) AS "Брой продажби",
    SUM(s.sale_price) AS "Общ оборот (лв)"
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
GROUP BY p.product_name, pg.group_name
ORDER BY COUNT(s.sale_id) DESC, SUM(s.sale_price) DESC
FETCH FIRST 10 ROWS ONLY;

-- ============================================
-- ЧАСТ 6: ДОПЪЛНИТЕЛНИ ПОЛЕЗНИ СПРАВКИ
-- ============================================

-- 6.1 Обща статистика за магазина
SELECT 
    (SELECT COUNT(*) FROM product) AS "Общо продукти",
    (SELECT COUNT(*) FROM client) AS "Общо клиенти",
    (SELECT COUNT(*) FROM employee) AS "Общо служители",
    (SELECT COUNT(*) FROM sale) AS "Общо продажби",
    (SELECT ROUND(SUM(sale_price), 2) FROM sale) AS "Общ оборот (лв)"
FROM DUAL;

-- 6.2 Най-активен служител (по брой продажби)
SELECT 
    e.employee_name AS "Служител",
    e.position AS "Позиция",
    COUNT(s.sale_id) AS "Брой продажби",
    ROUND(SUM(s.sale_price), 2) AS "Общ оборот (лв)",
    ROUND(AVG(s.sale_price), 2) AS "Средна продажба (лв)"
FROM sale s
JOIN employee e ON s.employee_id = e.employee_id
GROUP BY e.employee_name, e.position
ORDER BY COUNT(s.sale_id) DESC;

-- 6.3 Най-активен клиент (по брой покупки)
SELECT 
    c.client_name AS "Клиент",
    c.phone AS "Телефон",
    COUNT(s.sale_id) AS "Брой покупки",
    ROUND(SUM(s.sale_price), 2) AS "Обща сума (лв)",
    ROUND(AVG(s.sale_price), 2) AS "Средна покупка (лв)"
FROM sale s
JOIN client c ON s.client_id = c.client_id
GROUP BY c.client_name, c.phone
ORDER BY COUNT(s.sale_id) DESC;

-- 6.4 Месечен оборот за 2024
SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS "Месец",
    COUNT(sale_id) AS "Брой продажби",
    ROUND(SUM(sale_price), 2) AS "Оборот (лв)",
    ROUND(AVG(sale_price), 2) AS "Средна продажба (лв)"
FROM sale
WHERE EXTRACT(YEAR FROM sale_date) = 2024
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY TO_CHAR(sale_date, 'YYYY-MM');

-- 6.5 Продукти които не са продадени
SELECT 
    p.product_id,
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    p.price AS "Цена (лв)"
FROM product p
JOIN product_group pg ON p.group_id = pg.group_id
WHERE p.product_id NOT IN (SELECT DISTINCT product_id FROM sale)
ORDER BY pg.group_name, p.product_name;

-- 6.6 Средна цена по група
SELECT 
    pg.group_name AS "Група",
    COUNT(p.product_id) AS "Брой продукти",
    ROUND(MIN(p.price), 2) AS "Мин цена (лв)",
    ROUND(MAX(p.price), 2) AS "Макс цена (лв)",
    ROUND(AVG(p.price), 2) AS "Средна цена (лв)"
FROM product p
JOIN product_group pg ON p.group_id = pg.group_id
GROUP BY pg.group_name
ORDER BY AVG(p.price) DESC;

-- 6.7 Продажби по ден от седмицата
SELECT 
    TO_CHAR(sale_date, 'Day') AS "Ден",
    COUNT(sale_id) AS "Брой продажби",
    ROUND(SUM(sale_price), 2) AS "Оборот (лв)"
FROM sale
GROUP BY TO_CHAR(sale_date, 'Day'), TO_CHAR(sale_date, 'D')
ORDER BY TO_CHAR(sale_date, 'D');

-- Край на справки

