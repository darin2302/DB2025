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

-- 3.1 ПРОДАЖБИ ЗА ПЕРИОД (Януари - Март 2024) - детайлен изглед
SELECT 
    s.sale_id AS "ID Продажба",
    s.sale_date AS "Дата",
    c.client_name AS "Клиент",
    e.employee_name AS "Служител",
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    si.quantity AS "Количество",
    si.unit_price AS "Ед. цена",
    (si.quantity * si.unit_price) AS "Сума"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-03-31', 'YYYY-MM-DD')
ORDER BY s.sale_date ASC, s.sale_id, si.sale_item_id;

-- 3.2 ПРОДАЖБИ ЗА ПЕРИОД - обобщение по продажба
SELECT 
    s.sale_id AS "ID Продажба",
    s.sale_date AS "Дата",
    c.client_name AS "Клиент",
    e.employee_name AS "Служител",
    COUNT(si.sale_item_id) AS "Брой артикули",
    SUM(si.quantity) AS "Общо количество",
    SUM(si.quantity * si.unit_price) AS "Обща сума"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN sale_item si ON s.sale_id = si.sale_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-03-31', 'YYYY-MM-DD')
GROUP BY s.sale_id, s.sale_date, c.client_name, e.employee_name
ORDER BY s.sale_date ASC;

-- 3.3 ПРОДАЖБИ ЗА СЛУЖИТЕЛ, ПОДРЕДЕНИ ПО ДАТА
-- Служител: Мария Димитрова (employee_id = 2)
SELECT 
    s.sale_id AS "ID Продажба",
    s.sale_date AS "Дата",
    c.client_name AS "Клиент",
    COUNT(si.sale_item_id) AS "Брой артикули",
    SUM(si.quantity * si.unit_price) AS "Обща сума"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN sale_item si ON s.sale_id = si.sale_id
WHERE s.employee_id = 2
GROUP BY s.sale_id, s.sale_date, c.client_name
ORDER BY s.sale_date ASC;

-- 3.4 ПРОДАЖБИ ЗА СЛУЖИТЕЛ С ИМЕ - детайлен изглед
SELECT 
    e.employee_name AS "Служител",
    s.sale_date AS "Дата",
    c.client_name AS "Клиент",
    p.product_name AS "Продукт",
    si.quantity AS "Количество",
    si.unit_price AS "Ед. цена",
    (si.quantity * si.unit_price) AS "Сума"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
WHERE e.employee_name = 'Мария Димитрова'
ORDER BY s.sale_date ASC;

-- 3.5 ПРОДАЖБИ ЗА КЛИЕНТ
-- Клиент: Анна Николова (client_id = 1)
SELECT 
    c.client_name AS "Клиент",
    c.phone AS "Телефон",
    s.sale_date AS "Дата",
    e.employee_name AS "Обслужил",
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    si.quantity AS "Количество",
    si.unit_price AS "Ед. цена",
    (si.quantity * si.unit_price) AS "Сума"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.client_id = 1
ORDER BY s.sale_date DESC, si.sale_item_id;

-- 3.6 ПРОДАЖБИ ЗА КЛИЕНТ - обобщение
SELECT 
    c.client_name AS "Клиент",
    s.sale_date AS "Дата",
    COUNT(si.sale_item_id) AS "Брой артикули",
    SUM(si.quantity * si.unit_price) AS "Обща сума"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN sale_item si ON s.sale_id = si.sale_id
WHERE c.client_name = 'Анна Николова'
GROUP BY c.client_name, s.sale_id, s.sale_date
ORDER BY s.sale_date DESC;

-- ============================================
-- ЧАСТ 4: ОБОРОТ И БРОЙ ПРОДАЖБИ ПО ГРУПА
-- ============================================

-- 4.1 ОБОРОТ И БРОЙ ПРОДАЖБИ ПО ГРУПА ЗА ПЕРИОД (Цяла 2024)
SELECT 
    pg.group_name AS "Група",
    COUNT(DISTINCT s.sale_id) AS "Брой продажби",
    SUM(si.quantity) AS "Продадени бройки",
    SUM(si.quantity * si.unit_price) AS "Общ оборот (лв)",
    ROUND(AVG(si.unit_price), 2) AS "Средна ед. цена (лв)"
FROM sale s
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
GROUP BY pg.group_name
ORDER BY SUM(si.quantity * si.unit_price) DESC;

-- 4.2 ОБОРОТ И БРОЙ ПРОДАЖБИ ПО ГРУПА ЗА Q1 2024
SELECT 
    pg.group_name AS "Група",
    COUNT(DISTINCT s.sale_id) AS "Брой продажби",
    SUM(si.quantity) AS "Продадени бройки",
    SUM(si.quantity * si.unit_price) AS "Общ оборот (лв)",
    ROUND(SUM(si.quantity * si.unit_price) * 100.0 / 
        (SELECT SUM(si2.quantity * si2.unit_price) 
         FROM sale s2 
         JOIN sale_item si2 ON s2.sale_id = si2.sale_id
         WHERE s2.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                                AND TO_DATE('2024-03-31', 'YYYY-MM-DD')), 2) AS "% от оборота"
FROM sale s
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-03-31', 'YYYY-MM-DD')
GROUP BY pg.group_name
ORDER BY SUM(si.quantity * si.unit_price) DESC;

-- ============================================
-- ЧАСТ 5: ТОП ПРОДУКТИ ПО ОБОРОТ
-- ============================================

-- 5.1 ТОП 10 ПРОДУКТИ ПО ОБОРОТ ЗА ПЕРИОД (Цяла 2024)
SELECT 
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    SUM(si.quantity) AS "Продадени бройки",
    SUM(si.quantity * si.unit_price) AS "Общ оборот (лв)",
    ROUND(AVG(si.unit_price), 2) AS "Средна цена (лв)"
FROM sale s
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
GROUP BY p.product_name, pg.group_name
ORDER BY SUM(si.quantity * si.unit_price) DESC
FETCH FIRST 10 ROWS ONLY;

-- 5.2 ТОП 5 ПРОДУКТИ ПО ОБОРОТ ЗА Q2 2024
SELECT 
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    SUM(si.quantity) AS "Продадени бройки",
    SUM(si.quantity * si.unit_price) AS "Общ оборот (лв)"
FROM sale s
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-04-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-06-30', 'YYYY-MM-DD')
GROUP BY p.product_name, pg.group_name
ORDER BY SUM(si.quantity * si.unit_price) DESC
FETCH FIRST 5 ROWS ONLY;

-- 5.3 ТОП 10 ПРОДУКТИ ПО БРОЙ ПРОДАЖБИ
SELECT 
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    SUM(si.quantity) AS "Продадени бройки",
    COUNT(DISTINCT s.sale_id) AS "В колко продажби",
    SUM(si.quantity * si.unit_price) AS "Общ оборот (лв)"
FROM sale s
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id
WHERE s.sale_date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                     AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
GROUP BY p.product_name, pg.group_name
ORDER BY SUM(si.quantity) DESC, SUM(si.quantity * si.unit_price) DESC
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
    (SELECT COUNT(*) FROM sale_item) AS "Общо артикули",
    (SELECT ROUND(SUM(quantity * unit_price), 2) FROM sale_item) AS "Общ оборот (лв)"
FROM DUAL;

-- 6.2 Най-активен служител (по брой продажби и оборот)
SELECT 
    e.employee_name AS "Служител",
    pos.position_name AS "Позиция",
    COUNT(DISTINCT s.sale_id) AS "Брой продажби",
    SUM(si.quantity) AS "Продадени артикули",
    ROUND(SUM(si.quantity * si.unit_price), 2) AS "Общ оборот (лв)",
    ROUND(AVG(si.quantity * si.unit_price), 2) AS "Средна стойност на артикул (лв)"
FROM sale s
JOIN employee e ON s.employee_id = e.employee_id
JOIN position pos ON e.position_id = pos.position_id
JOIN sale_item si ON s.sale_id = si.sale_id
GROUP BY e.employee_name, pos.position_name
ORDER BY SUM(si.quantity * si.unit_price) DESC;

-- 6.3 Най-активен клиент (по брой покупки и обща сума)
SELECT 
    c.client_name AS "Клиент",
    c.phone AS "Телефон",
    COUNT(DISTINCT s.sale_id) AS "Брой покупки",
    SUM(si.quantity) AS "Общо артикули",
    ROUND(SUM(si.quantity * si.unit_price), 2) AS "Обща сума (лв)",
    ROUND(AVG(si.quantity * si.unit_price), 2) AS "Средна стойност на артикул (лв)"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN sale_item si ON s.sale_id = si.sale_id
GROUP BY c.client_name, c.phone
ORDER BY SUM(si.quantity * si.unit_price) DESC;

-- 6.4 Месечен оборот за 2024
SELECT 
    TO_CHAR(s.sale_date, 'YYYY-MM') AS "Месец",
    COUNT(DISTINCT s.sale_id) AS "Брой продажби",
    SUM(si.quantity) AS "Продадени артикули",
    ROUND(SUM(si.quantity * si.unit_price), 2) AS "Оборот (лв)",
    ROUND(AVG(si.quantity * si.unit_price), 2) AS "Средна стойност на артикул (лв)"
FROM sale s
JOIN sale_item si ON s.sale_id = si.sale_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2024
GROUP BY TO_CHAR(s.sale_date, 'YYYY-MM')
ORDER BY TO_CHAR(s.sale_date, 'YYYY-MM');

-- 6.5 Продукти които не са продадени
SELECT 
    p.product_id,
    p.product_name AS "Продукт",
    pg.group_name AS "Група",
    p.price AS "Цена (лв)"
FROM product p
JOIN product_group pg ON p.group_id = pg.group_id
WHERE p.product_id NOT IN (SELECT DISTINCT product_id FROM sale_item)
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
    TO_CHAR(s.sale_date, 'Day') AS "Ден",
    COUNT(DISTINCT s.sale_id) AS "Брой продажби",
    SUM(si.quantity) AS "Продадени артикули",
    ROUND(SUM(si.quantity * si.unit_price), 2) AS "Оборот (лв)"
FROM sale s
JOIN sale_item si ON s.sale_id = si.sale_id
GROUP BY TO_CHAR(s.sale_date, 'Day'), TO_CHAR(s.sale_date, 'D')
ORDER BY TO_CHAR(s.sale_date, 'D');

-- 6.8 Всички служители с техните позиции
SELECT 
    e.employee_id AS "ID",
    e.employee_name AS "Служител",
    pos.position_name AS "Позиция",
    e.phone AS "Телефон"
FROM employee e
JOIN position pos ON e.position_id = pos.position_id
ORDER BY pos.position_name, e.employee_name;

-- 6.9 Брой служители по позиция
SELECT 
    pos.position_name AS "Позиция",
    COUNT(e.employee_id) AS "Брой служители"
FROM position pos
LEFT JOIN employee e ON pos.position_id = e.position_id
GROUP BY pos.position_name
ORDER BY COUNT(e.employee_id) DESC;

-- 6.10 Средна стойност на продажба (кошница)
SELECT 
    s.sale_id AS "ID Продажба",
    s.sale_date AS "Дата",
    c.client_name AS "Клиент",
    COUNT(si.sale_item_id) AS "Брой артикули",
    SUM(si.quantity) AS "Общо бройки",
    ROUND(SUM(si.quantity * si.unit_price), 2) AS "Обща сума (лв)"
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN sale_item si ON s.sale_id = si.sale_id
GROUP BY s.sale_id, s.sale_date, c.client_name
ORDER BY SUM(si.quantity * si.unit_price) DESC;

-- 6.11 Използване на VIEW v_sale_details
SELECT * FROM v_sale_details
ORDER BY sale_date DESC, sale_id;

-- 6.12 Използване на VIEW v_sale_summary
SELECT * FROM v_sale_summary
ORDER BY total_amount DESC;

-- Край на справки
