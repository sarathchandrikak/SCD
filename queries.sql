ALTER TABLE sales
ALTER COLUMN transaction_id TYPE VARCHAR
USING transaction_id::VARCHAR;

-- Cleaned employees table
UPDATE employees
SET phone = REGEXP_REPLACE(phone, '^''', '')
WHERE phone LIKE '''%';


-- Create Stage Employees a new table to track new data in employee table
CREATE TABLE stage_employees (
	employee_id INT,
	name VARCHAR,
	title VARCHAR,
	birthday DATE,
	email VARCHAR,
	phone VARCHAR
);
-- Insert into stage table the new / updated records
INSERT INTO stage_employees (
	employee_id,
	name,
	title,
	birthday,
	email,
	phone
) VALUES (
	500016,
	'Jennifer Wilson',
	'Analyst',
	'1989-07-28',
	'donna35@example.com',
	'+1-244-696-5100'
);

-- Merge query to do SCD 1
MERGE INTO employees
USING stage_employees 
ON employees.employee_id = stage_employees.employee_id

WHEN MATCHED THEN 
UPDATE SET
  name = stage_employees.name,
  title = stage_employees.title,
  email = stage_employees.email,
  phone = stage_employees.phone

WHEN NOT MATCHED THEN 
INSERT (
  employee_id,
  name,
  title,
  birthday,
  email,
  phone
) VALUES (
  stage_employees.employee_id,
  stage_employees.name,
  stage_employees.title,
  stage_employees.birthday,
  stage_employees.email,
  stage_employees.phone
);

select * from employees where employee_id = 500016;

-- Create stage table on items table

CREATE TABLE stage_items (
	item_id INT,
	name VARCHAR,
	price FLOAT,
	category_id INT,
	placement VARCHAR,
	start_date DATE,
	end_date DATE
);

-- Insert data into stage_items table
INSERT INTO stage_items (
	item_id,
	name,
	price,
	category_id,
	placement,
	start_date,
	end_date
) VALUES (
	800014,
	'Sports Jersey',
	49.99,
	726,
	'Entry Display',
	'2023-11-13',
	NULL
);


-- Merge stage table and original table to get SCD type 2

MERGE INTO items AS target
USING stage_items AS source
ON target.item_id = source.item_id
   AND target.start_date < source.start_date
   AND target.end_date IS NULL

WHEN MATCHED THEN
UPDATE SET
  name = source.name,
  price = source.price,
  category_id = source.category_id,
  placement = source.placement,
  start_date = target.start_date,
  end_date = source.start_date

WHEN NOT MATCHED THEN
INSERT (
  item_id,
  name,
  price,
  category_id,
  placement,
  start_date,
  end_date
) VALUES (
  source.item_id,
  source.name,
  source.price,
  source.category_id,
  source.placement,
  source.start_date,
  NULL
);

-- Create stage table for SCD Type 3

CREATE TABLE stage_discounts (
	discount_id INTEGER,
	name VARCHAR,
	is_seasonal BOOLEAN,
	percent_off INTEGER
);

-- Insert data for which discout percentage got updated
INSERT INTO stage_discounts (
	discount_id,
	name,
	is_seasonal,
	percent_off
) VALUES (
	1000030,
	'Rewards Member',
	FALSE,
	35
);

MERGE INTO discounts AS target
USING stage_discounts AS source
ON target.discount_id = source.discount_id

WHEN MATCHED AND target.percent_off <> source.percent_off THEN
UPDATE SET
  previous_percent_off = target.percent_off,
  percent_off = source.percent_off

WHEN NOT MATCHED THEN
INSERT (
  discount_id,
  name,
  is_seasonal_discount,
  percent_off,
  previous_percent_off
)
VALUES (
  source.discount_id,
  source.name,
  source.is_seasonal,
  source.percent_off,
  NULL
);