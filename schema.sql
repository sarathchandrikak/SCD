CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    title VARCHAR(100),
    birthday DATE,
    email VARCHAR(100),
    phone VARCHAR(20)
);
    
CREATE TABLE discounts (
    discount_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    is_seasonal_discount BOOLEAN,
    percent_off NUMERIC(5,2),
    previous_percent_off NUMERIC(5,2)
);

CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2),
    category_id INT,
    placement VARCHAR(100),
    start_date DATE,
    end_date DATE
);

CREATE TABLE sales (
    transaction_id SERIAL PRIMARY KEY,
    date_sold DATE,
    employee_id INT,
    item_id INT,
    quantity_sold INT,
    discount_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id),
    FOREIGN KEY (discount_id) REFERENCES discounts(discount_id)
);
