-- Lesson 23: UNION, DISTINCT, UPDATE, Transactions



CREATE TABLE logs_data (
	id serial PRIMARY KEY,
	log_text VARCHAR(100)
);


SELECT * 
FROM logs_data
ORDER BY id;


INSERT INTO logs_data (log_text)
VALUES ('test text');


INSERT INTO logs_data (log_text)
SELECT 'test select 4' AS log_text;


INSERT INTO logs_data (log_text)
SELECT 'test select 1' AS log_text
UNION ALL
SELECT 'test select 2' AS log_text
UNION ALL
SELECT 'test select 3' AS log_text
UNION ALL
SELECT log_text 
FROM logs_data
ORDER BY log_text;



SELECT DISTINCT id
FROM logs_data;


SELECT DISTINCT log_text 
FROM logs_data;


UPDATE logs_data
SET log_text = 'changed text'
WHERE id IN (1, 2);

/*
UPDATE logs_data
SET id = 10
WHERE id = 7;

ALTER SEQUENCE logs_data_id_seq RESTART WITH 1;
*/



CREATE TABLE market (
	id serial,
	city varchar(50),
	house_address varchar(100),
	price REAL,
	for_sale boolean NOT NULL DEFAULT TRUE,
	PRIMARY KEY (id)
);

CREATE TABLE sold (
	id int NOT NULL,
	city varchar(50),
	house_address varchar(100),
	price REAL,
	PRIMARY KEY (id)
);


SELECT *
FROM market;

SELECT *
FROM sold;


INSERT INTO market
SELECT 1 AS id, 'Seattle' AS city, '3573 Honeysuckle Lane' AS house_address, 150000 AS price, TRUE AS for_sale
UNION ALL
SELECT 2 AS id, 'Daytona Beach' AS city, '3685 Spirit Drive' AS house_address, 230000 AS price, TRUE AS for_sale
UNION ALL
SELECT 3 AS id, 'Bakersfield' AS city, '3773 Williams Avenue' AS house_address, 80000.5 AS price, TRUE AS for_sale
UNION ALL
SELECT 4 AS id, 'Houston' AS city, '3202 Grey Fox Farm Road' AS house_address, 330000.1 AS price, TRUE AS for_sale
UNION ALL
SELECT 5 AS id, 'Summum' AS city, '4707 Simpson Street' AS house_address, 170000 AS price, TRUE AS for_sale
;

-- New transaction of selling houses
BEGIN TRANSACTION;

UPDATE market
SET for_sale = FALSE 
WHERE id IN (1, 4, 5);

INSERT INTO sold
SELECT id, city, house_address, price
FROM market
WHERE for_sale = FALSE;

DELETE FROM market
WHERE for_sale = FALSE;

COMMIT TRANSACTION;



