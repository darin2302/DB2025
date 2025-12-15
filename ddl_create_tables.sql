-- ============================================
-- ПРОЕКТ БАЗА ДАННИ - МАГАЗИН
-- DDL КОМАНДИ (Data Definition Language)
-- ============================================

-- Изтриване на таблиците ако съществуват (за тестване)
DROP TABLE IF EXISTS sale_item CASCADE;
DROP TABLE IF EXISTS sale CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS product_group CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS position CASCADE;
DROP TABLE IF EXISTS client CASCADE;

-- ============================================
-- 1. ТАБЛИЦА: PRODUCT_GROUP (Група продукти)
-- ============================================
CREATE TABLE product_group (
    group_id NUMBER(10) PRIMARY KEY,
    group_name VARCHAR2(100) NOT NULL UNIQUE
);

-- Коментари за документация
COMMENT ON TABLE product_group IS 'Групи продукти (електроника, дрехи, храна и т.н.)';
COMMENT ON COLUMN product_group.group_id IS 'Уникален идентификатор на групата';
COMMENT ON COLUMN product_group.group_name IS 'Наименование на групата';

-- ============================================
-- 2. ТАБЛИЦА: PRODUCT (Продукт)
-- ============================================
CREATE TABLE product (
    product_id NUMBER(10) PRIMARY KEY,
    product_name VARCHAR2(200) NOT NULL,
    group_id NUMBER(10) NOT NULL,
    price NUMBER(10, 2) NOT NULL CHECK (price >= 0),
    CONSTRAINT fk_product_group 
        FOREIGN KEY (group_id) 
        REFERENCES product_group(group_id)
        ON DELETE RESTRICT
);

-- Индекси за по-бързо търсене
CREATE INDEX idx_product_name ON product(product_name);
CREATE INDEX idx_product_group ON product(group_id);
CREATE INDEX idx_product_price ON product(price);

-- Коментари
COMMENT ON TABLE product IS 'Продукти в магазина';
COMMENT ON COLUMN product.product_id IS 'Уникален идентификатор на продукта';
COMMENT ON COLUMN product.product_name IS 'Наименование на продукта';
COMMENT ON COLUMN product.group_id IS 'Връзка към групата на продукта';
COMMENT ON COLUMN product.price IS 'Текуща цена на продукта';

-- ============================================
-- 3. ТАБЛИЦА: POSITION (Позиция/Длъжност)
-- ============================================
CREATE TABLE position (
    position_id NUMBER(10) PRIMARY KEY,
    position_name VARCHAR2(100) NOT NULL UNIQUE
);

-- Коментари
COMMENT ON TABLE position IS 'Длъжности на служителите (мениджър, продавач, касиер и т.н.)';
COMMENT ON COLUMN position.position_id IS 'Уникален идентификатор на длъжността';
COMMENT ON COLUMN position.position_name IS 'Наименование на длъжността';

-- ============================================
-- 4. ТАБЛИЦА: EMPLOYEE (Служител)
-- ============================================
CREATE TABLE employee (
    employee_id NUMBER(10) PRIMARY KEY,
    employee_name VARCHAR2(200) NOT NULL,
    position_id NUMBER(10) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_employee_position 
        FOREIGN KEY (position_id) 
        REFERENCES position(position_id)
        ON DELETE RESTRICT
);

-- Индекси за търсене
CREATE INDEX idx_employee_name ON employee(employee_name);
CREATE INDEX idx_employee_position ON employee(position_id);

-- Коментари
COMMENT ON TABLE employee IS 'Служители в магазина';
COMMENT ON COLUMN employee.employee_id IS 'Уникален идентификатор на служителя';
COMMENT ON COLUMN employee.employee_name IS 'Име на служителя';
COMMENT ON COLUMN employee.position_id IS 'Връзка към длъжността на служителя';
COMMENT ON COLUMN employee.phone IS 'Телефон за връзка';

-- ============================================
-- 5. ТАБЛИЦА: CLIENT (Клиент)
-- ============================================
CREATE TABLE client (
    client_id NUMBER(10) PRIMARY KEY,
    client_name VARCHAR2(200) NOT NULL,
    phone VARCHAR2(20) NOT NULL
);

-- Индекс за търсене по име
CREATE INDEX idx_client_name ON client(client_name);

-- Коментари
COMMENT ON TABLE client IS 'Клиенти на магазина';
COMMENT ON COLUMN client.client_id IS 'Уникален идентификатор на клиента';
COMMENT ON COLUMN client.client_name IS 'Име на клиента';
COMMENT ON COLUMN client.phone IS 'Телефон за връзка';

-- ============================================
-- 6. ТАБЛИЦА: SALE (Продажба - заглавна част)
-- ============================================
CREATE TABLE sale (
    sale_id NUMBER(10) PRIMARY KEY,
    client_id NUMBER(10) NOT NULL,
    employee_id NUMBER(10) NOT NULL,
    sale_date DATE NOT NULL,
    CONSTRAINT fk_sale_client 
        FOREIGN KEY (client_id) 
        REFERENCES client(client_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_sale_employee 
        FOREIGN KEY (employee_id) 
        REFERENCES employee(employee_id)
        ON DELETE RESTRICT
);

-- Индекси за оптимизация на справките
CREATE INDEX idx_sale_date ON sale(sale_date);
CREATE INDEX idx_sale_client ON sale(client_id);
CREATE INDEX idx_sale_employee ON sale(employee_id);

-- Коментари
COMMENT ON TABLE sale IS 'Продажби в магазина (заглавна информация)';
COMMENT ON COLUMN sale.sale_id IS 'Уникален идентификатор на продажбата';
COMMENT ON COLUMN sale.client_id IS 'Клиент който е закупил';
COMMENT ON COLUMN sale.employee_id IS 'Служител който е обслужил';
COMMENT ON COLUMN sale.sale_date IS 'Дата на продажбата';

-- ============================================
-- 7. ТАБЛИЦА: SALE_ITEM (Артикули в продажба)
-- ============================================
CREATE TABLE sale_item (
    sale_item_id NUMBER(10) PRIMARY KEY,
    sale_id NUMBER(10) NOT NULL,
    product_id NUMBER(10) NOT NULL,
    quantity NUMBER(10) NOT NULL CHECK (quantity > 0),
    unit_price NUMBER(10, 2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT fk_sale_item_sale 
        FOREIGN KEY (sale_id) 
        REFERENCES sale(sale_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_sale_item_product 
        FOREIGN KEY (product_id) 
        REFERENCES product(product_id)
        ON DELETE RESTRICT
);

-- Индекси за оптимизация
CREATE INDEX idx_sale_item_sale ON sale_item(sale_id);
CREATE INDEX idx_sale_item_product ON sale_item(product_id);

-- Коментари
COMMENT ON TABLE sale_item IS 'Артикули (редове) в продажба';
COMMENT ON COLUMN sale_item.sale_item_id IS 'Уникален идентификатор на реда';
COMMENT ON COLUMN sale_item.sale_id IS 'Връзка към продажбата';
COMMENT ON COLUMN sale_item.product_id IS 'Продукт който е продаден';
COMMENT ON COLUMN sale_item.quantity IS 'Количество';
COMMENT ON COLUMN sale_item.unit_price IS 'Единична цена към момента на продажбата';

-- ============================================
-- SEQUENCES за автоматично генериране на ID-та
-- ============================================
CREATE SEQUENCE seq_product_group START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_product START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_position START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_employee START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_client START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sale START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sale_item START WITH 1 INCREMENT BY 1;

-- ============================================
-- ИЗГЛЕД (VIEW) за полезна информация
-- ============================================
CREATE OR REPLACE VIEW v_sale_details AS
SELECT 
    s.sale_id,
    s.sale_date,
    c.client_name,
    c.phone AS client_phone,
    e.employee_name,
    pos.position_name AS employee_position,
    p.product_name,
    pg.group_name,
    si.quantity,
    si.unit_price,
    (si.quantity * si.unit_price) AS line_total
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN position pos ON e.position_id = pos.position_id
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id;

COMMENT ON VIEW v_sale_details IS 'Детайлен изглед на всички продажби с пълна информация';

-- ============================================
-- ИЗГЛЕД (VIEW) за обобщение на продажби
-- ============================================
CREATE OR REPLACE VIEW v_sale_summary AS
SELECT 
    s.sale_id,
    s.sale_date,
    c.client_name,
    e.employee_name,
    COUNT(si.sale_item_id) AS items_count,
    SUM(si.quantity) AS total_quantity,
    SUM(si.quantity * si.unit_price) AS total_amount
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN sale_item si ON s.sale_id = si.sale_id
GROUP BY s.sale_id, s.sale_date, c.client_name, e.employee_name;

COMMENT ON VIEW v_sale_summary IS 'Обобщен изглед на продажби с общи суми';
