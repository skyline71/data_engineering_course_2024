-- Lesson 39: Data marts


-- 1. Создание и заполнение таблиц словарей и фактов

CREATE TABLE d_cities (
	id serial PRIMARY KEY,
	city_name VARCHAR(50)
);

CREATE TABLE d_products (
	id serial PRIMARY KEY,
	product_name VARCHAR(100)
);

CREATE TABLE d_customers (
	id serial PRIMARY KEY,
	city_id INT NOT NULL,
	customer_name VARCHAR(100),
	bank_account VARCHAR(50),
	tax_number VARCHAR(50)
);

CREATE TABLE f_orders (
	id serial PRIMARY KEY,
	city_id INT NOT NULL,
	product_id INT NOT NULL,
	customer_id INT NOT NULL,
	buy_time timestamp NOT NULL DEFAULT NOW(),
	amount FLOAT NOT NULL,
	costs FLOAT NOT NULL
);

INSERT INTO d_cities (city_name)
SELECT 'Moscow' AS city_name
UNION ALL
SELECT 'Paris' AS city_name
UNION ALL
SELECT 'Seattle' AS city_name
UNION ALL
SELECT 'Belgrade' AS city_name
UNION ALL
SELECT 'Berlin' AS city_name;

INSERT INTO d_products (product_name)
SELECT 'Clothes' AS product_name
UNION ALL
SELECT 'Smartphone' AS product_name
UNION ALL
SELECT 'Healthcare' AS product_name
UNION ALL
SELECT 'Food' AS product_name
UNION ALL
SELECT 'Car' AS product_name;

INSERT INTO d_customers (city_id, customer_name, bank_account, tax_number)
SELECT 1 AS city_id, 'Jack Heines' AS customer_name, '123456789' AS bank_account, '100000345678' AS tax_number
UNION ALL
SELECT 2 AS city_id, 'Steve Book' AS customer_name, '567892345' AS bank_account, '200038488200' AS tax_number
UNION ALL
SELECT 3 AS city_id, 'Alan Paul' AS customer_name, '329329100' AS bank_account, '128893000993' AS tax_number
UNION ALL
SELECT 4 AS city_id, 'Dan Midway' AS customer_name, '993993145' AS bank_account, '334343000001' AS tax_number
UNION ALL
SELECT 5 AS city_id, 'Colin Stark' AS customer_name, '153435677' AS bank_account, '757575338800' AS tax_number;

INSERT INTO f_orders (city_id, product_id, customer_id, amount, costs)
SELECT 4 AS city_id, 1 AS product_id, 2 AS customer_id, 7000.0 AS amount, 25000.0 AS costs
UNION ALL
SELECT 5 AS city_id, 2 AS product_id, 3 AS customer_id, 5500.0 AS amount, 41000.0 AS costs
UNION ALL
SELECT 3 AS city_id, 3 AS product_id, 5 AS customer_id, 3200.0 AS amount, 16450.0 AS costs
UNION ALL
SELECT 1 AS city_id, 4 AS product_id, 4 AS customer_id, 4050.0 AS amount, 8000.0 AS costs
UNION ALL
SELECT 2 AS city_id, 5 AS product_id, 1 AS customer_id, 2700.0 AS amount, 11300.0 AS costs;


SELECT *
FROM d_cities;

SELECT *
FROM d_products;

SELECT *
FROM d_customers;

SELECT *
FROM f_orders;


INSERT INTO f_orders (city_id, product_id, customer_id, amount, costs)
SELECT 4 AS city_id, 1 AS product_id, 2 AS customer_id, 1100.0 AS amount, 5000.0 AS costs
UNION ALL
SELECT 5 AS city_id, 2 AS product_id, 3 AS customer_id, 2050.0 AS amount, 3250.0 AS costs
UNION ALL
SELECT 3 AS city_id, 3 AS product_id, 5 AS customer_id, 600.0 AS amount, 6450.0 AS costs
UNION ALL
SELECT 1 AS city_id, 4 AS product_id, 4 AS customer_id, 450.0 AS amount, 2000.0 AS costs
UNION ALL
SELECT 2 AS city_id, 5 AS product_id, 1 AS customer_id, 1500.0 AS amount, 4300.0 AS costs;


-- 2. Создание и заполнение агрегатов и витрин данных

UPDATE f_orders
SET buy_time = buy_time + INTERVAL '2 DAY';

-- Пример агрегата

SELECT buy_time::date AS buy_date, city_id,	product_id,	customer_id, SUM(amount) AS total_amount, SUM(costs) AS total_costs
FROM f_orders
GROUP BY buy_date, city_id,	product_id,	customer_id;

-- Пример витрины данных

SELECT O.buy_time::date AS buy_date,
	   C.city_name AS order_city_name, 
	   P.product_name AS product_name, 
	   CU.customer_name AS customer_name,
	   C1.city_name AS customer_city_name,
	   CU.bank_account AS bank_account,  
	   SUM(amount) AS total_amount,
	   SUM(costs) AS total_costs
FROM f_orders O
LEFT JOIN d_cities C ON
	O.city_id = C.id
LEFT JOIN d_products P ON
	O.product_id = P.id
LEFT JOIN d_customers CU ON
	O.customer_id = CU.id
LEFT JOIN d_cities C1 ON
	CU.city_id = C1.id
GROUP BY buy_date, order_city_name, product_name, customer_name, customer_city_name, bank_account;


CREATE TABLE dm_orders (
	buy_date DATE NOT NULL,
	order_city_name VARCHAR(50),
	product_name VARCHAR(100),
	customer_name VARCHAR(100),
	customer_city_name VARCHAR(50),
	bank_account VARCHAR(50),
	total_amount FLOAT NOT NULL,
	total_costs FLOAT NOT NULL
);

INSERT INTO dm_orders (buy_date, order_city_name, product_name, customer_name, customer_city_name, bank_account, total_amount, total_costs)
SELECT O.buy_time::date AS buy_date,
	   C.city_name AS order_city_name, 
	   P.product_name AS product_name, 
	   CU.customer_name AS customer_name,
	   C1.city_name AS customer_city_name,
	   CU.bank_account AS bank_account,  
	   SUM(amount) AS total_amount,
	   SUM(costs) AS total_costs
FROM f_orders O
LEFT JOIN d_cities C ON
	O.city_id = C.id
LEFT JOIN d_products P ON
	O.product_id = P.id
LEFT JOIN d_customers CU ON
	O.customer_id = CU.id
LEFT JOIN d_cities C1 ON
	CU.city_id = C1.id
WHERE O.buy_time::date = '2024-10-03'::date
GROUP BY buy_date, order_city_name, product_name, customer_name, customer_city_name, bank_account;


SELECT *
FROM dm_orders;

-- 3. Проверка работы DAGа c авто-заполнением данных из f_orders в витрину данных dm_orders

INSERT INTO f_orders (city_id, product_id, customer_id, amount, costs)
SELECT 4 AS city_id, 1 AS product_id, 2 AS customer_id, 500.0 AS amount, 500.0 AS costs
UNION ALL
SELECT 5 AS city_id, 2 AS product_id, 3 AS customer_id, 250.0 AS amount, 350.0 AS costs
UNION ALL
SELECT 3 AS city_id, 3 AS product_id, 5 AS customer_id, 100.0 AS amount, 650.0 AS costs
UNION ALL
SELECT 1 AS city_id, 4 AS product_id, 4 AS customer_id, 350.0 AS amount, 200.0 AS costs
UNION ALL
SELECT 2 AS city_id, 5 AS product_id, 1 AS customer_id, 550.0 AS amount, 430.0 AS costs;


SELECT *
FROM dm_orders;



