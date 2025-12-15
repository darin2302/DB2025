# ДОКУМЕНТАЦИЯ ПО ПРОЕКТ ЗА БАЗИ ДАННИ
---

## Дарин Пенчев
Специалност: **СИТ**

Kурс: **2** 

Група: **1A**

Факултетен номер: **24621653**

## СЪДЪРЖАНИЕ

1. [Задание](#1-задание)
2. [Концептуален модел](#2-концептуален-модел)
3. [Логически модел](#3-логически-модел)
4. [Физически модел](#4-физически-модел)
5. [Примерни данни](#5-примерни-данни)
6. [SQL команди](#6-sql-команди)
7. [Резултати от заявки](#7-резултати-от-заявки)
8. [Оптимизация](#8-оптимизация)
9. [Заключение](#9-заключение)

---

## 1. ЗАДАНИЕ

Да се проектира и реализира база от данни за **МАГАЗИН**, която да съхранява следната информация:

### 1.1 Основни данни

- **Продукт**: наименование, група, цена
- **Служител**: име, позиция, телефон
- **Клиент**: име, телефон
- **Продажба**: продукти (множество), клиент, служител, дата, цени

### 1.2 Бизнес правила

1. Всеки продукт принадлежи на **една** група
2. Всеки служител заема **една** позиция/длъжност
3. Всеки клиент може да закупи **много** продукти
4. Всеки служител може да обслужи **много** продажби
5. Всяка продажба може да включва **много** продукти (артикули)
6. Всяка продажба включва един клиент и един служител

### 1.3 Функционални изисквания

**Операции:**
- Въвеждане и корекции на данни
- Търсене/закупуване на продукти по: цена, наименование, група

**Справки:**
- Продажби за период
- Продажби за служител, подредени по дата
- Продажби за клиент
- Оборот и брой продажби по група за период
- Топ продукти по оборот за период

---

## 2. КОНЦЕПТУАЛЕН МОДЕЛ

### 2.1 ER Диаграма

> <img src="./diagrams/ER_Diagram.png">
> Файл: `diagrams/ER_Diagram.png`

### 2.2 Entities и атрибути

#### PRODUCT_GROUP (Група продукти)
- **group_id** (PK) - Уникален идентификатор на групата
- **group_name** - Наименование на групата

#### PRODUCT (Продукт)
- **product_id** (PK) - Уникален идентификатор на продукта
- **product_name** - Наименование на продукта
- **group_id** (FK) - Връзка към група
- **price** - Цена на продукта

#### POSITION (Позиция/Длъжност)
- **position_id** (PK) - Уникален идентификатор на позицията
- **position_name** - Наименование на длъжността

#### EMPLOYEE (Служител)
- **employee_id** (PK) - Уникален идентификатор на служителя
- **employee_name** - Име на служителя
- **position_id** (FK) - Връзка към позиция/длъжност
- **phone** - Телефон за връзка

#### CLIENT (Клиент)
- **client_id** (PK) - Уникален идентификатор на клиента
- **client_name** - Име на клиента
- **phone** - Телефон за връзка

#### SALE (Продажба - заглавна част)
- **sale_id** (PK) - Уникален идентификатор на продажбата
- **client_id** (FK) - Връзка към клиент
- **employee_id** (FK) - Връзка към служител
- **sale_date** - Дата на продажбата

#### SALE_ITEM (Артикул в продажба)
- **sale_item_id** (PK) - Уникален идентификатор на реда
- **sale_id** (FK) - Връзка към продажба
- **product_id** (FK) - Връзка към продукт
- **quantity** - Количество
- **unit_price** - Единична цена към момента на продажбата

### 2.3 Релации

```
PRODUCT_GROUP (1) ────< (M) PRODUCT
   └─ Една група съдържа много продукти
   └─ Всеки продукт принадлежи на точно една група

POSITION (1) ────< (M) EMPLOYEE
   └─ Една позиция може да бъде заемана от много служители
   └─ Всеки служител заема точно една позиция

CLIENT (1) ────< (M) SALE
   └─ Един клиент може да направи много покупки

EMPLOYEE (1) ────< (M) SALE
   └─ Един служител може да обслужи много продажби

SALE (1) ────< (M) SALE_ITEM
   └─ Една продажба съдържа много артикули (редове)
   └─ Всеки артикул принадлежи на точно една продажба

PRODUCT (1) ────< (M) SALE_ITEM
   └─ Един продукт може да бъде включен в много продажби
```

### 2.4 Кардиналност и участие

| Релация                | Кардиналност | Участие Parent | Участие Child |
|------------------------|--------------|----------------|---------------|
| PRODUCT_GROUP → PRODUCT| 1:M          | Частично       | Задължително  |
| POSITION → EMPLOYEE    | 1:M          | Частично       | Задължително  |
| CLIENT → SALE          | 1:M          | Частично       | Задължително  |
| EMPLOYEE → SALE        | 1:M          | Частично       | Задължително  |
| SALE → SALE_ITEM       | 1:M          | Задължително   | Задължително  |
| PRODUCT → SALE_ITEM    | 1:M          | Частично       | Задължително  |

---

## 3. ЛОГИЧЕСКИ МОДЕЛ

### 3.1 Нормализация

Моделът е проектиран да отговаря на **Третата Нормална Форма (3NF)**:

#### Първа нормална форма (1NF)
**Изпълнено:**
- Всички атрибути съдържат атомарни (неделими) стойности
- Няма повтарящи се групи от атрибути
- Всяка таблица има първичен ключ
- Всички редове са уникални

#### Втора нормална форма (2NF)
**Изпълнено:**
- Моделът е в 1NF
- Всички неключови атрибути зависят изцяло от първичния ключ
- Няма частични зависимости (всички primary keys са единични, не композитни)

#### Трета нормална форма (3NF)
**Изпълнено:**
- Моделът е в 2NF
- Няма транзитивни зависимости между неключови атрибути
- Групата на продукта е изнесена в отделна таблица PRODUCT_GROUP
- Позицията на служителя е изнесена в отделна таблица POSITION
- Артикулите на продажбата са изнесени в отделна таблица SALE_ITEM
- Цената на артикула се запазва в SALE_ITEM за исторически данни

### 3.2 Обосновка на дизайна

**Защо PRODUCT_GROUP е отделна таблица?**
- Избягване на дублиране на данни (имената на групите се повтарят)
- Улеснява промяна на име на група (един UPDATE вместо много)
- Позволява добавяне на допълнителна информация за групата в бъдеще

**Защо POSITION е отделна таблица?**
- Стандартизиране на длъжностите (избягване на несъответствия като "Продавач" vs "продавач")
- Улеснява промяна на име на позиция (един UPDATE вместо много)
- Позволява добавяне на допълнителна информация за позицията в бъдеще (напр. заплата, ниво)
- Улеснява справки и филтриране по позиция

**Защо SALE_ITEM е отделна таблица?**
- Позволява една продажба да съдържа много продукти (кошница)
- Всеки артикул има собствено количество и цена
- Цената се запазва към момента на продажбата (исторически данни)
- Улеснява анализ на продажби по продукт

**Защо unit_price се дублира в SALE_ITEM?**
- Исторически данни: цената на продукта може да се промени
- Продажбата трябва да запази цената към момента на транзакцията
- Позволява анализ на ценова политика във времето

---

## 4. ФИЗИЧЕСКИ МОДЕЛ

### 4.1 Релационна схема

![Physical Model](diagrams/ER_Diagram.png)

### 4.2 DDL Скриптове

#### Таблица PRODUCT_GROUP

```sql
CREATE TABLE product_group (
    group_id NUMBER(10) PRIMARY KEY,
    group_name VARCHAR2(100) NOT NULL UNIQUE
);

COMMENT ON TABLE product_group IS 'Групи продукти (електроника, дрехи, храна и т.н.)';
```

#### Таблица PRODUCT

```sql
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

-- Индекси за оптимизация
CREATE INDEX idx_product_name ON product(product_name);
CREATE INDEX idx_product_group ON product(group_id);
CREATE INDEX idx_product_price ON product(price);
```

#### Таблица POSITION

```sql
CREATE TABLE position (
    position_id NUMBER(10) PRIMARY KEY,
    position_name VARCHAR2(100) NOT NULL UNIQUE
);

COMMENT ON TABLE position IS 'Длъжности на служителите (мениджър, продавач, касиер и т.н.)';
```

#### Таблица EMPLOYEE

```sql
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

CREATE INDEX idx_employee_name ON employee(employee_name);
CREATE INDEX idx_employee_position ON employee(position_id);
```

#### Таблица CLIENT

```sql
CREATE TABLE client (
    client_id NUMBER(10) PRIMARY KEY,
    client_name VARCHAR2(200) NOT NULL,
    phone VARCHAR2(20) NOT NULL
);

CREATE INDEX idx_client_name ON client(client_name);
```

#### Таблица SALE

```sql
CREATE TABLE sale (
    sale_id NUMBER(10) PRIMARY KEY,
    client_id NUMBER(10) NOT NULL,
    employee_id NUMBER(10) NOT NULL,
    sale_date DATE NOT NULL,
    CONSTRAINT fk_sale_client 
        FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE RESTRICT,
    CONSTRAINT fk_sale_employee 
        FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE RESTRICT
);

CREATE INDEX idx_sale_date ON sale(sale_date);
CREATE INDEX idx_sale_client ON sale(client_id);
CREATE INDEX idx_sale_employee ON sale(employee_id);
```

#### Таблица SALE_ITEM

```sql
CREATE TABLE sale_item (
    sale_item_id NUMBER(10) PRIMARY KEY,
    sale_id NUMBER(10) NOT NULL,
    product_id NUMBER(10) NOT NULL,
    quantity NUMBER(10) NOT NULL CHECK (quantity > 0),
    unit_price NUMBER(10, 2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT fk_sale_item_sale 
        FOREIGN KEY (sale_id) REFERENCES sale(sale_id) ON DELETE CASCADE,
    CONSTRAINT fk_sale_item_product 
        FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE RESTRICT
);

CREATE INDEX idx_sale_item_sale ON sale_item(sale_id);
CREATE INDEX idx_sale_item_product ON sale_item(product_id);
```

### 4.3 Constraints (Ограничения)

| Тип Constraint    | Таблица        | Описание                                      |
|-------------------|----------------|-----------------------------------------------|
| PRIMARY KEY       | Всички         | Уникален идентификатор на всеки ред           |
| FOREIGN KEY       | PRODUCT        | Връзка към PRODUCT_GROUP                      |
| FOREIGN KEY       | EMPLOYEE       | Връзка към POSITION                           |
| FOREIGN KEY       | SALE           | Връзки към CLIENT, EMPLOYEE                   |
| FOREIGN KEY       | SALE_ITEM      | Връзки към SALE, PRODUCT                      |
| NOT NULL          | Всички         | Задължителни полета                           |
| UNIQUE            | PRODUCT_GROUP  | Уникално име на група                         |
| UNIQUE            | POSITION       | Уникално име на позиция                       |
| CHECK             | PRODUCT        | Цената не може да бъде отрицателна            |
| CHECK             | SALE_ITEM      | Количеството > 0, цената >= 0                 |
| ON DELETE RESTRICT| Повечето FK    | Предотвратява изтриване при съществуващи връзки|
| ON DELETE CASCADE | SALE_ITEM→SALE | Изтрива артикулите при изтриване на продажба  |

### 4.4 Sequences и Views

```sql
-- Автоматично генериране на ID-та
CREATE SEQUENCE seq_product_group START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_product START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_position START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_employee START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_client START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sale START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sale_item START WITH 1 INCREMENT BY 1;

-- View за детайлна информация за продажби
CREATE OR REPLACE VIEW v_sale_details AS
SELECT 
    s.sale_id, s.sale_date,
    c.client_name, c.phone AS client_phone,
    e.employee_name, pos.position_name AS employee_position,
    p.product_name, pg.group_name,
    si.quantity, si.unit_price,
    (si.quantity * si.unit_price) AS line_total
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN position pos ON e.position_id = pos.position_id
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id;

-- View за обобщение на продажби
CREATE OR REPLACE VIEW v_sale_summary AS
SELECT 
    s.sale_id, s.sale_date,
    c.client_name, e.employee_name,
    COUNT(si.sale_item_id) AS items_count,
    SUM(si.quantity) AS total_quantity,
    SUM(si.quantity * si.unit_price) AS total_amount
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN sale_item si ON s.sale_id = si.sale_id
GROUP BY s.sale_id, s.sale_date, c.client_name, e.employee_name;
```

---

## 5. ПРИМЕРНИ ДАННИ

### 5.1 Статистика

| Таблица        | Брой записи | Описание                          |
|----------------|-------------|-----------------------------------|
| PRODUCT_GROUP  | 6           | Категории продукти                |
| PRODUCT        | 30          | Различни продукти                 |
| POSITION       | 4           | Длъжности на служителите          |
| EMPLOYEE       | 5           | Служители на магазина             |
| CLIENT         | 10          | Регистрирани клиенти              |
| SALE           | 25          | Продажби за период 5 месеца       |
| SALE_ITEM      | 47          | Артикули в продажбите             |

### 5.2 Групи продукти

1. **Електроника** - Лаптопи, телефони, аксесоари
2. **Дрехи** - Облекло и обувки
3. **Храна и напитки** - Хранителни стоки
4. **Козметика** - Козметични продукти
5. **Книги** - Литература и учебници
6. **Спортни стоки** - Спортно оборудване

### 5.3 Позиции/Длъжности

| ID | Позиция          | Описание                                    |
|----|------------------|---------------------------------------------|
| 1  | Мениджър         | Управлява магазина и персонала              |
| 2  | Продавач         | Обслужва клиенти и извършва продажби        |
| 3  | Старши продавач  | Опитен продавач с допълнителни отговорности |
| 4  | Касиер           | Обработва плащания на касата                |

### 5.4 Примерни продукти (извадка)

| ID | Продукт                    | Група           | Цена (лв) |
|----|----------------------------|-----------------|-----------|
| 1  | Лаптоп Dell XPS 15         | Електроника     | 2,499.99  |
| 2  | Смартфон iPhone 14         | Електроника     | 1,899.00  |
| 6  | Дънки Levi's 501           | Дрехи           | 129.99    |
| 11 | Кафе Lavazza 1кг           | Храна и напитки | 18.50     |
| 12 | Шоколад Milka 100г         | Храна и напитки | 2.49      |
| 29 | Велосипед Trek Mountain    | Спортни стоки   | 899.00    |

### 5.5 Служители

| ID | Име                  | Позиция          | Телефон        |
|----|----------------------|------------------|----------------|
| 1  | Иван Петров          | Мениджър         | +359888111222  |
| 2  | Мария Димитрова      | Продавач         | +359888222333  |
| 3  | Георги Стоянов       | Продавач         | +359888333444  |
| 4  | Елена Иванова        | Старши продавач  | +359888444555  |
| 5  | Петър Георгиев       | Касиер           | +359888555666  |

### 5.6 Примерна продажба (кошница)

**Продажба #1** (05.01.2024, Клиент: Анна Николова, Служител: Мария Димитрова)

| Продукт                    | Количество | Ед. цена | Сума      |
|----------------------------|------------|----------|-----------|
| Лаптоп Dell XPS 15         | 1          | 2,499.99 | 2,499.99  |
| Мишка Logitech MX Master   | 1          | 99.99    | 99.99     |
| **Общо:**                  | **2**      |          | **2,599.98** |

### 5.7 Период на данните

- **Начало:** 01.01.2024
- **Край:** 31.05.2024
- **Продължителност:** 5 месеца
- **Брой транзакции:** 25
- **Брой артикули:** 47

---

## 6. SQL КОМАНДИ

### 6.1 DDL - Data Definition Language

**Файл:** `ddl_create_tables.sql`

Съдържа:
- `CREATE TABLE` за 7 таблици
- 14 индекса за оптимизация
- 7 sequences за автоматично генериране на ID
- 2 views за детайлни справки
- Коментари на всички таблици и колони

### 6.2 DML - Data Manipulation Language

**Файл:** `dml_sample_data.sql`

**INSERT команди:**
- 6 групи продукти
- 30 продукта (по 5 от всяка група)
- 4 позиции/длъжности
- 5 служителя
- 10 клиента
- 25 продажби
- 47 артикула в продажбите

**UPDATE и DELETE примери:**
```sql
-- Корекция на цена
UPDATE product SET price = 2399.99 WHERE product_id = 1;

-- Промяна на телефон
UPDATE employee SET phone = '+359888111333' WHERE employee_id = 1;

-- Изтриване на продажба (CASCADE изтрива и артикулите)
DELETE FROM sale WHERE sale_id = 26;
```

### 6.3 DQL - Data Query Language

**Файл:** `queries.sql`

Съдържа **24 заявки** организирани в 6 категории:
1. Въвеждане и корекции (5 заявки)
2. Търсене на продукти (5 заявки)
3. Справки за продажби (6 заявки)
4. Оборот по група (2 заявки)
5. Топ продукти (3 заявки)
6. Допълнителни анализи (12 заявки)

---

## 7. РЕЗУЛТАТИ ОТ ЗАЯВКИТЕ

### 7.1 Търсене на продукти по цена

**Заявка:** Продукти под 50 лв

**Резултат (извадка):**

| Продукт                       | Цена (лв) | Група           |
|-------------------------------|-----------|-----------------|
| Шоколад Milka 100г            | 2.49      | Храна и напитки |
| Паста Barilla 500г            | 2.99      | Храна и напитки |
| Минерална вода Bankya 6л      | 3.99      | Храна и напитки |
| Крем Nivea Anti-Age           | 12.99     | Козметика       |
| Под игото - Иван Вазов        | 15.00     | Книги           |

### 7.2 Продажби за период - обобщение

**Заявка:** Продажби от 01.01.2024 до 31.03.2024

**Резултат (извадка):**

| Дата       | Клиент          | Служител        | Артикули | Обща сума |
|------------|-----------------|-----------------|----------|-----------|
| 2024-01-05 | Анна Николова   | Мария Димитрова | 2        | 2,599.98  |
| 2024-01-08 | Христо Василев  | Георги Стоянов  | 2        | 20.43     |
| 2024-01-10 | Димитър Тодоров | Мария Димитрова | 3        | 244.98    |

### 7.3 Оборот и брой продажби по група

**Заявка:** Статистика по групи за цяла 2024 г.

**Резултат:**

| Група           | Продажби | Продадени бр. | Оборот (лв) |
|-----------------|----------|---------------|-------------|
| Електроника     | 8        | 10            | 12,547.88   |
| Спортни стоки   | 5        | 7             | 1,232.97    |
| Дрехи           | 5        | 10            | 918.95      |
| Козметика       | 4        | 8             | 330.93      |
| Храна и напитки | 8        | 35            | 194.26      |
| Книги           | 4        | 5             | 132.00      |

### 7.4 Топ 10 продукти по оборот

**Резултат:**

| # | Продукт                     | Група         | Бройки | Оборот (лв) |
|---|-----------------------------|---------------|--------|-------------|
| 1 | Лаптоп Dell XPS 15          | Електроника   | 2      | 4,999.98    |
| 2 | Смартфон iPhone 14          | Електроника   | 1      | 1,899.00    |
| 3 | Слушалки Sony WH-1000XM5    | Електроника   | 3      | 1,199.97    |
| 4 | Велосипед Trek Mountain     | Спортни стоки | 1      | 899.00      |
| 5 | Таблет Samsung Galaxy Tab   | Електроника   | 1      | 649.00      |

---

## 8. ОПТИМИЗАЦИЯ

### 8.1 Индекси

Създадени са **14 индекса** за оптимизация на заявките:

| Индекс               | Таблица    | Колона        | Цел                               |
|----------------------|------------|---------------|-----------------------------------|
| PK индекси           | Всички     | *_id          | Бърз достъп по уникален ключ      |
| idx_product_name     | PRODUCT    | product_name  | Търсене по име на продукт         |
| idx_product_price    | PRODUCT    | price         | Търсене по ценови диапазон        |
| idx_product_group    | PRODUCT    | group_id      | Филтриране по група               |
| idx_employee_name    | EMPLOYEE   | employee_name | Търсене на служител               |
| idx_employee_position| EMPLOYEE   | position_id   | Филтриране по позиция             |
| idx_client_name      | CLIENT     | client_name   | Търсене на клиент                 |
| idx_sale_date        | SALE       | sale_date     | Филтриране по период              |
| idx_sale_client      | SALE       | client_id     | JOIN оптимизация                  |
| idx_sale_employee    | SALE       | employee_id   | JOIN оптимизация                  |
| idx_sale_item_sale   | SALE_ITEM  | sale_id       | JOIN оптимизация                  |
| idx_sale_item_product| SALE_ITEM  | product_id    | JOIN оптимизация                  |

### 8.2 View оптимизация

`v_sale_details` и `v_sale_summary` views съкращават сложни JOIN заявки:

**Без view:**
```sql
SELECT s.sale_id, p.product_name, pg.group_name, c.client_name, 
       e.employee_name, pos.position_name, si.quantity, si.unit_price
FROM sale s
JOIN client c ON s.client_id = c.client_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN position pos ON e.position_id = pos.position_id
JOIN sale_item si ON s.sale_id = si.sale_id
JOIN product p ON si.product_id = p.product_id
JOIN product_group pg ON p.group_id = pg.group_id;
```

**С view:**
```sql
SELECT * FROM v_sale_details;
```

### 8.3 Референциална цялост

**ON DELETE RESTRICT** на повечето foreign keys гарантира:
- Не може да се изтрие продукт който има продажби
- Не може да се изтрие клиент който има история на покупки
- Не може да се изтрие служител който е обслужил продажби
- Не може да се изтрие група докато има продукти в нея
- Не може да се изтрие позиция докато има служители на тази позиция

**ON DELETE CASCADE** на SALE_ITEM→SALE гарантира:
- При изтриване на продажба, автоматично се изтриват всички артикули

---
