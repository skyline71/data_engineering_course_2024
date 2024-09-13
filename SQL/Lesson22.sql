-- Lesson 22: SELECT, WHERE, AND, OR, LIKE



SELECT *
FROM d_miners
WHERE
	id = 3
	OR id = 5;


SELECT *
FROM d_miners
WHERE
	id >= 3
	AND create_date < now();


SELECT *
FROM d_miners
WHERE
	id IN (1, 2, 3, 4, 5)
	AND id IS NULL;


SELECT *
FROM d_customers
WHERE
	id IN (2, 4, 5)
	OR create_date >= '2022-03-15'::date::timestamp;
	

SELECT *
FROM d_customers
WHERE
	industry_area = 'Energy'
	AND create_date > '2022-01-05'::date::timestamp;
	

SELECT *
FROM d_customers
WHERE
	email_address = 'acme@corporate.com'
	OR email_address = 'info@zeta.com';
	

SELECT *
FROM d_ore
WHERE
	amount > 500
	AND amount <= 1800;
	

SELECT *
FROM d_ore
WHERE
	amount >= 1000
	AND price_per_kg < 10;
	

SELECT *
FROM d_ore
WHERE
	ore_type = 'Iron'
	OR id = 1;
	

SELECT *
FROM d_employee
WHERE
	miner_id IN (2, 5)
	OR name = 'John';
	

SELECT *
FROM d_employee
WHERE
	id > 3
	AND status = 'Stopped';


SELECT *
FROM d_employee
WHERE
	e_position IN ('Engineer', 'Operator')
	AND start_work_date > '2022-01-01'::date;


SELECT *
FROM f_salary
WHERE
	id < 3
	OR efficiency < 5;


SELECT *
FROM f_salary
WHERE
	(salary < 50000
	OR efficiency >= 9)
	AND employee_id > 2;


SELECT *
FROM f_salary
WHERE
	create_date >= '2022-07-01'::date
	AND efficiency > 4;


SELECT *
FROM f_application
WHERE
	ID >= 4
	OR price < 2000;


SELECT *
FROM f_application
WHERE
	(customer_id = 3
	OR miner_id = 3
	OR ore_id  = 3)
	AND amount >= 100;


SELECT *
FROM f_application
WHERE
	amount > 150
	AND price > 1500
	AND customer_id > 3;


SELECT *
FROM d_customers
WHERE
	company_name LIKE '%es';


SELECT *
FROM d_customers
WHERE
	bank_account LIKE '%123'
	OR bank_account LIKE '%123_';


SELECT *
FROM d_employee
WHERE
	name LIKE 'J%';


SELECT *
FROM d_employee
WHERE
	phone_number LIKE '%4';


SELECT *
FROM d_miners
WHERE
	email_address NOT LIKE '%@%.com';


SELECT *
FROM d_miners
WHERE
	physical_address LIKE '___ %';


SELECT *
FROM d_ore
WHERE
	ore_type LIKE '%er'
	OR ore_type LIKE '%o%'

	

