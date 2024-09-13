-- Lesson 21 Part 1: CREATE TABLE, dictionary tables, fact tables



CREATE TABLE d_miners(
    id int UNIQUE NOT NULL,
    company_name varchar(50),
    physical_address varchar(50),
    email_address varchar(50),
    phone_number varchar(20),
    create_date timestamp NOT NULL DEFAULT now(),
    end_date timestamp DEFAULT '2040-01-01'::date::timestamp,
    PRIMARY KEY (id, create_date)
);

CREATE TABLE d_customers(
    id int UNIQUE NOT NULL,
    company_name varchar(50),
    industry_area varchar(50),
    bank_account varchar(12),
    phone_number varchar(20),
    email_address varchar(50),
    create_date timestamp NOT NULL DEFAULT now(),
    end_date timestamp DEFAULT '2040-01-01'::date::timestamp,
    PRIMARY KEY (id, create_date)
);

CREATE TABLE d_ore(
    id serial NOT NULL,
    ore_type VARCHAR(100),
    amount int,
    price_per_kg real,
    UNIQUE (ore_type),
    PRIMARY KEY (id)
);

CREATE TABLE d_employee(
    id int UNIQUE NOT NULL,
    miner_id int NOT NULL REFERENCES d_miners (id),
    name varchar(50),
    surname varchar(50),
    e_position varchar(255),
    status varchar(255),
    phone_number varchar(20),
    begin_date timestamp NOT NULL DEFAULT now(),
    end_date timestamp DEFAULT '2040-01-01'::date::timestamp,
    start_work_date date,
    PRIMARY KEY (id, begin_date)
);


CREATE TABLE f_application(
    id serial NOT NULL,
    customer_id int NOT NULL REFERENCES d_customers (id),
    miner_id int NOT NULL REFERENCES d_miners (id),
    ore_id int NOT NULL REFERENCES d_ore (id),
    amount int,
    price real,
    create_date timestamp,
    PRIMARY KEY (id)
);

CREATE TABLE f_salary(
    id serial NOT NULL,
    employee_id int NOT NULL REFERENCES d_employee (id),
    efficiency int NOT NULL DEFAULT 0,
    salary real,
    create_date timestamp,
    PRIMARY KEY (id)
);


INSERT INTO d_miners (id, company_name, physical_address, email_address, phone_number, create_date, end_date)
VALUES
(1, 'Mining Co. Alpha', '123 Mine St, Cityville', 'contact@alpha.com', '+1234567890', '2022-01-01 10:00:00', '2040-01-01'),
(2, 'Beta Resources', '456 Gold Rd, Townsville', 'info@beta.com', '+1234567891', '2022-02-01 11:00:00', '2040-01-01'),
(3, 'Gamma Mining Ltd', '789 Silver Ln, Villagetown', 'support@gamma.com', '+1234567892', '2022-03-01 12:00:00', '2040-01-01'),
(4, 'Delta Diggers', '101 Coal Ave, Miningtown', 'sales@delta.com', '+1234567893', '2022-04-01 13:00:00', '2040-01-01'),
(5, 'Epsilon Extractors', '202 Iron St, Quarryville', 'hello@epsilon.com', '+1234567894', '2022-05-01 14:00:00', '2040-01-01');


INSERT INTO d_customers (id, company_name, industry_area, bank_account, phone_number, email_address, create_date, end_date)
VALUES
(1, 'Acme Corporation', 'Manufacturing', '123456789012', '+9876543210', 'acme@corporate.com', '2022-01-05 09:00:00', '2040-01-01'),
(2, 'Omega Industries', 'Construction', '234567890123', '+9876543211', 'contact@omega.com', '2022-02-10 10:30:00', '2040-01-01'),
(3, 'Zeta Ventures', 'Logistics', '345678901234', '+9876543212', 'info@zeta.com', '2022-03-15 11:45:00', '2040-01-01'),
(4, 'Theta Enterprises', 'Retail', '456789012345', '+9876543213', 'support@theta.com', '2022-04-20 14:00:00', '2040-01-01'),
(5, 'Iota Holdings', 'Energy', '567890123456', '+9876543214', 'sales@iota.com', '2022-05-25 16:15:00', '2040-01-01');


INSERT INTO d_ore (ore_type, amount, price_per_kg)
VALUES
('Gold', 500, 57.5),
('Silver', 1000, 23.0),
('Copper', 1500, 8.2),
('Iron', 2000, 4.0),
('Uranium', 300, 95.0);


INSERT INTO d_employee (id, miner_id, name, surname, e_position, status, phone_number, begin_date, end_date, start_work_date)
VALUES
(1, 1, 'John', 'Doe', 'Engineer', 'Active', '+4567891230', '2022-01-01 08:00:00', '2040-01-01', '2022-01-01'),
(2, 2, 'Jim', 'Beam', 'Technician', 'Active', '+4567891231', '2022-03-01 10:00:00', '2040-01-01', '2022-03-01'),
(3, 3, 'Jack', 'Daniels', 'Manager', 'Active', '+4567891232', '2022-04-01 11:00:00', '2040-01-01', '2022-04-01'),
(4, 4, 'Jill', 'Valentine', 'Operator', 'Active', '+4567891233', '2022-05-01 12:00:00', '2040-01-01', '2022-05-01'),
(5, 5, 'Alice', 'Johnson', 'Geologist', 'Active', '+4567891234', '2022-06-01 13:00:00', '2040-01-01', '2022-06-01');


INSERT INTO f_application (id, customer_id, miner_id, ore_id, amount, price, create_date)
VALUES
(1, 1, 3, 1, 100, 5750.0, '2022-06-01 10:00:00'),
(2, 2, 1, 5, 200, 4600.0, '2022-06-02 11:30:00'),
(3, 3, 2, 4, 150, 1230.0, '2022-06-03 12:45:00'),
(4, 4, 5, 2, 300, 1200.0, '2022-06-04 14:15:00'),
(5, 5, 4, 3, 50, 4750.0, '2022-06-05 15:30:00');


INSERT INTO f_salary (id, employee_id, efficiency, salary, create_date)
VALUES
(1, 1, 7, 69105.0, '2022-06-01 10:00:00'),
(2, 2, 3, 41808.0, '2022-07-01 11:00:00'),
(3, 3, 5, 50820.0, '2022-08-01 12:00:00'),
(4, 4, 9, 75175.0, '2022-09-01 13:00:00'),
(5, 5, 4, 46459.0, '2022-10-01 14:00:00');


SELECT * FROM d_miners;

SELECT * FROM d_customers;

SELECT * FROM d_ore;

SELECT * FROM d_employee;

SELECT * FROM f_application;

SELECT * FROM f_salary;

TRUNCATE TABLE f_application RESTART IDENTITY;


INSERT INTO f_application (id, customer_id, miner_id, ore_id, amount, price, create_date)
SELECT 6 AS id, 4 AS customer_id, 5 AS miner_id, 1 AS ore_id, 100 AS amount, 19500.0 AS price, '2022-06-01 14:00:00'::date::timestamp AS create_date
UNION ALL
SELECT 7 AS id, 3 AS customer_id, 5 AS miner_id, 3 AS ore_id, 150 AS amount, 8000.0 AS price, '2022-07-01 15:30:00'::date::timestamp AS create_date
UNION ALL
SELECT 8 AS id, 2 AS customer_id, 1 AS miner_id, 3 AS ore_id, 200 AS amount, 9200.0 AS price, '2022-08-01 09:45:00'::date::timestamp AS create_date
UNION ALL
SELECT 9 AS id, 1 AS customer_id, 2 AS miner_id, 4 AS ore_id, 50 AS amount, 2500.0 AS price, '2022-09-01 13:15:00'::date::timestamp AS create_date
UNION ALL
SELECT 10 AS id, 5 AS customer_id, 3 AS miner_id, 4 AS ore_id, 75 AS amount, 4350.0 AS price, '2022-10-01 10:00:00'::date::timestamp AS create_date
;




