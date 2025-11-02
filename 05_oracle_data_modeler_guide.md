# РЪКОВОДСТВО ЗА ORACLE DATA MODELER

## Стъпка 1: Инсталация

1. Изтеглете **Oracle SQL Developer Data Modeler** от:
   https://www.oracle.com/database/sqldeveloper/technologies/sql-data-modeler/download/

2. Разархивирайте файла и стартирайте `datamodeler.exe` (Windows) или `datamodeler.sh` (Linux/Mac)

---

## Стъпка 2: Създаване на нов проект

1. Отворете Oracle Data Modeler
2. File → New → Design
3. Изберете име: **Магазин_БД**
4. Save As → `Магазин_Проект.dmd`

---

## Стъпка 3: Създаване на Логически Модел (Logical Model)

### 3.1 Създаване на Entity: PRODUCT_GROUP

1. От лентата с инструменти изберете **Entity**
2. Кликнете на канавата за да го поставите
3. Двоен клик → Properties
4. Name: `PRODUCT_GROUP`

**Атрибути:**
- `group_id` - Number(10) - **Primary Key** (UID1)
- `group_name` - Varchar2(100) - **Mandatory**

### 3.2 Създаване на Entity: PRODUCT

**Атрибути:**
- `product_id` - Number(10) - **Primary Key** (UID1)
- `product_name` - Varchar2(200) - **Mandatory**
- `group_id` - Number(10) - **Mandatory, Foreign Key**
- `price` - Number(10,2) - **Mandatory**

### 3.3 Създаване на Entity: EMPLOYEE

**Атрибути:**
- `employee_id` - Number(10) - **Primary Key** (UID1)
- `employee_name` - Varchar2(200) - **Mandatory**
- `position` - Varchar2(100) - **Mandatory**
- `phone` - Varchar2(20) - **Mandatory**

### 3.4 Създаване на Entity: CLIENT

**Атрибути:**
- `client_id` - Number(10) - **Primary Key** (UID1)
- `client_name` - Varchar2(200) - **Mandatory**
- `phone` - Varchar2(20) - **Mandatory**

### 3.5 Създаване на Entity: SALE

**Атрибути:**
- `sale_id` - Number(10) - **Primary Key** (UID1)
- `product_id` - Number(10) - **Mandatory, Foreign Key**
- `client_id` - Number(10) - **Mandatory, Foreign Key**
- `employee_id` - Number(10) - **Mandatory, Foreign Key**
- `sale_date` - Date - **Mandatory**
- `sale_price` - Number(10,2) - **Mandatory**

---

## Стъпка 4: Създаване на Релации (Relations)

### 4.1 Релация: PRODUCT_GROUP → PRODUCT (1:M)

1. Изберете **1:N Relation** от toolbar
2. Кликнете първо на **PRODUCT_GROUP** (родител)
3. После кликнете на **PRODUCT** (дете)
4. Properties:
   - Name: `FK_PRODUCT_GROUP`
   - Cardinality: **1:N** (One to Many)
   - Optionality: **Mandatory** (всеки продукт ТРЯБВА да има група)

### 4.2 Релация: PRODUCT → SALE (1:M)

1. **1:N Relation**
2. От **PRODUCT** → към **SALE**
3. Properties:
   - Name: `FK_SALE_PRODUCT`
   - Cardinality: **1:N**
   - Optionality: **Mandatory**

### 4.3 Релация: CLIENT → SALE (1:M)

1. **1:N Relation**
2. От **CLIENT** → към **SALE**
3. Properties:
   - Name: `FK_SALE_CLIENT`
   - Cardinality: **1:N**
   - Optionality: **Mandatory**

### 4.4 Релация: EMPLOYEE → SALE (1:M)

1. **1:N Relation**
2. От **EMPLOYEE** → към **SALE**
3. Properties:
   - Name: `FK_SALE_EMPLOYEE`
   - Cardinality: **1:N**
   - Optionality: **Mandatory**

---

## Стъпка 5: Физически Модел (Relational Model)

1. Menu: **Tools** → **Design Rules**
2. Verify → проверете за грешки
3. Menu: **Engineer to Relational Model**
4. Това ще създаде автоматично физическия модел с таблици

---

## Стъпка 6: Генериране на DDL скрипт

1. File → Export → DDL File
2. Изберете:
   - Database: **Oracle Database 12c** (или по-нова версия)
   - Include: Tables, Constraints, Indexes, Comments
3. Save As: `generated_ddl.sql`

**Алтернатива:** Използвайте готовия скрипт `02_ddl_create_tables.sql`

---

## Стъпка 7: Генериране на диаграми за документация

### 7.1 Export на ER диаграма като снимка

1. Изберете Logical Model view
2. File → Export → To Image
3. Format: PNG или PDF
4. Resolution: 300 DPI (за висока резолюция)
5. Save As: `ER_Diagram.png`

### 7.2 Export на Relational Model

1. Изберете Relational Model view
2. File → Export → To Image
3. Save As: `Relational_Diagram.png`

---

## Стъпка 8: Документиране в PDF

1. File → Print Diagram → Print to PDF
2. Включете:
   - Logical Model
   - Relational Model
   - Data Dictionary (речник на данните)
3. Save As: `Магазин_БД_Модели.pdf`

---

## Полезни съвети за Data Modeler

### Добавяне на коментари
1. Right-click на Entity → Properties
2. Tab: **General** → Comment
3. Въведете описание на български

### Форматиране на диаграмата
- Използвайте **Auto Layout** за подреждане: Diagram → Auto Layout
- Align entities: Edit → Align → ...
- Uniform Size: Edit → Size → Make Same Size

### Валидация
- Tools → **Validate Model** (преди експорт)
- Проверете за:
  - ✓ Primary Keys на всички entities
  - ✓ Foreign Keys са правилно свързани
  - ✓ Mandatory атрибути са маркирани
  - ✓ Data types са правилни

### Експорт в различни бази
Можете да генерирате DDL за:
- Oracle
- MySQL
- PostgreSQL
- SQL Server

Просто изберете желаната база при Export → DDL File

---

## Визуализация на структурата

```
┌──────────────────┐
│ PRODUCT_GROUP    │
├──────────────────┤
│ PK group_id      │
│    group_name    │
└────────┬─────────┘
         │ 1
         │
         │ M
┌────────┴─────────┐         ┌──────────────┐
│ PRODUCT          │         │ EMPLOYEE     │
├──────────────────┤         ├──────────────┤
│ PK product_id    │         │ PK emp_id    │
│    product_name  │         │    name      │
│ FK group_id      │         │    position  │
│    price         │         │    phone     │
└────────┬─────────┘         └──────┬───────┘
         │ 1                        │ 1
         │                          │
         │ M                        │ M
         │         ┌────────────────┴────────┐
         │         │                         │
         │    ┌────┴─────────┐               │
         └────► SALE         │               │
              ├──────────────┤               │
              │ PK sale_id   │◄──────────────┘
              │ FK product_id│               
              │ FK client_id │◄──────────────┐
              │ FK emp_id    │               │
              │    sale_date │               │ 1
              │    price     │               │
              └──────────────┘               │
                                             │ M
                                    ┌────────┴──────┐
                                    │ CLIENT        │
                                    ├───────────────┤
                                    │ PK client_id  │
                                    │    name       │
                                    │    phone      │
                                    └───────────────┘
```

---

## Checkpoint: Какво трябва да имате

✅ Logical Model с 5 entities и 4 релации  
✅ Relational Model с 5 таблици  
✅ Експортирани PNG/PDF диаграми  
✅ Генериран DDL скрипт (или използвайте готовия)  
✅ Валидиран модел без грешки  

Готово! Вашият модел е завършен. 🎉

