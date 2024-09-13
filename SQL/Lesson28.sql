-- Lesson 28: CTE (WITH .. AS), Window functions (ROW_NUMBER) 

CREATE TABLE soldier (
	brigade_id int NOT NULL,
	full_name varchar(50) NOT NULL DEFAULT '',
	created_date date NOT NULL DEFAULT NOW(),
	soldier_status varchar(50) NOT NULL DEFAULT 'Принят',
	PRIMARY KEY (brigade_id, created_date)
);


INSERT INTO soldier
SELECT 1 AS brigade_id, 'Иван Петров' AS full_name, '2020-05-01'::date AS created_date, 'Принят' AS soldier_status
UNION ALL
SELECT 1 AS brigade_id, 'Денис Максимов' AS full_name, '2020-06-05'::date AS created_date, 'Принят' AS soldier_status
UNION ALL
SELECT 1 AS brigade_id, 'Макар Семёнов' AS full_name, '2020-08-10'::date AS created_date, 'Принят' AS soldier_status
UNION ALL
SELECT 2 AS brigade_id, 'Дмитрий Андреев' AS full_name, '2021-09-03'::date AS created_date, 'Принят' AS soldier_status
UNION ALL
SELECT 3 AS brigade_id, 'Сергей Никитин' AS full_name, '2021-12-01'::date AS created_date, 'Принят' AS soldier_status
UNION ALL
SELECT 3 AS brigade_id, 'Олег Иванов' AS full_name, '2022-01-31'::date AS created_date, 'Принят' AS soldier_status
UNION ALL
SELECT 3 AS brigade_id, 'Сергей Никитин' AS full_name, '2022-03-11'::date AS created_date, 'Дезертировал' AS soldier_status
UNION ALL
SELECT 1 AS brigade_id, 'Макар Семёнов' AS full_name, '2022-05-04'::date AS created_date, 'Погиб' AS soldier_status
UNION ALL
SELECT 1 AS brigade_id, 'Иван Петров' AS full_name, '2022-10-16'::date AS created_date, 'Дезертировал' AS soldier_status
UNION ALL
SELECT 2 AS brigade_id, 'Дмитрий Андреев' AS full_name, '2022-11-21'::date AS created_date, 'Вернули обратно на фронт' AS soldier_status
UNION ALL
SELECT 1 AS brigade_id, 'Денис Максимов' AS full_name, '2023-01-17'::date AS created_date, 'Погиб' AS soldier_status
UNION ALL
SELECT 2 AS brigade_id, 'Алексей Степанов' AS full_name, '2023-02-24'::date AS created_date, 'Принят' AS soldier_status
UNION ALL
SELECT 2 AS brigade_id, 'Виталий Васильев' AS full_name, '2023-02-26'::date AS created_date, 'Принят' AS soldier_status
;


SELECT *
FROM soldier
ORDER BY created_date
;

-- Задача 1 - Сколько человек было в каком взводе на конкретную дату
WITH soldiers AS (
	SELECT *
	FROM soldier
	WHERE
		created_date <= NOW()
	ORDER BY brigade_id, full_name 
),
dead_soldiers AS (
	SELECT full_name
	FROM soldiers
	WHERE
		soldier_status IN ('Погиб', 'Дезертировал')
),
last_dates AS (
	SELECT brigade_id, full_name, MAX(created_date) AS last_created_date
	FROM soldiers
	WHERE
		full_name NOT IN (SELECT * FROM dead_soldiers)
	GROUP BY brigade_id, full_name
),
alive_soldiers AS (
	SELECT S.brigade_id, S.full_name, S.soldier_status, S.created_date
	FROM soldiers S
	JOIN last_dates L ON
		S.brigade_id = L.brigade_id
		AND S.full_name = L.full_name
		AND S.created_date = L.last_created_date
),
alive_count AS (
	SELECT brigade_id, COUNT(*) AS count_alive
	FROM alive_soldiers
	GROUP BY brigade_id
)
SELECT DISTINCT S.brigade_id, COALESCE(A.count_alive, 0)
FROM soldier S
LEFT JOIN alive_count A ON
	S.brigade_id = A.brigade_id
ORDER BY 1
;


-- Задача 2 - Вывести полный список людей в каждом взводе на конкретную дату
WITH soldiers AS (
	SELECT *
	FROM soldier
	WHERE
		created_date <= '2022-12-31'
	ORDER BY brigade_id, full_name 
),
dead_soldiers AS (
	SELECT full_name
	FROM soldiers
	WHERE
		soldier_status IN ('Погиб', 'Дезертировал')
),
last_dates AS (
	SELECT brigade_id, full_name, MAX(created_date) AS last_created_date
	FROM soldiers
	WHERE
		full_name NOT IN (SELECT * FROM dead_soldiers)
	GROUP BY brigade_id, full_name
),
alive_soldiers AS (
	SELECT S.brigade_id, S.full_name, S.soldier_status, S.created_date
	FROM soldiers S
	JOIN last_dates L ON
		S.brigade_id = L.brigade_id
		AND S.full_name = L.full_name
		AND S.created_date = L.last_created_date
),
alive_count AS (
	SELECT brigade_id, COUNT(*) AS count_alive
	FROM alive_soldiers
	GROUP BY brigade_id
)
SELECT S.brigade_id, S.full_name, S.soldier_status, S.created_date, C.count_alive
FROM alive_soldiers S
JOIN alive_count C ON
	S.brigade_id = C.brigade_id
;


-- Задача 2 - Через ROW_NUMBER()
WITH dead_soldiers AS (
	SELECT full_name
	FROM soldier
	WHERE
		soldier_status IN ('Погиб', 'Дезертировал')
		AND created_date <= '2022-12-31'
)
SELECT S.brigade_id, S.full_name, S.soldier_status, S.created_date
FROM (
	SELECT *, ROW_NUMBER() OVER(PARTITION BY brigade_id, full_name ORDER BY created_date DESC) AS N
	FROM soldier
	WHERE
		created_date <= '2022-12-31'
		AND full_name NOT IN (SELECT * FROM dead_soldiers)
) S
WHERE S.N = 1
;


-- Window functions
SELECT *, ROW_NUMBER() OVER() AS N
FROM soldier 
;

SELECT *, RANK() OVER(ORDER BY created_date DESC) AS N
FROM soldier 
;

SELECT *, RANK() OVER(PARTITION BY brigade_id, full_name ORDER BY created_date DESC) AS N
FROM soldier 
;


-------------------------------------------------------------------------------------------------------

-- Последний статус каждого бойца через CTE
WITH soldiers_agg AS (
	SELECT brigade_id, full_name, MAX(created_date) AS max_created_date
	FROM soldier
	GROUP BY brigade_id, full_name
)
SELECT S.brigade_id, S.full_name, S.created_date, S.soldier_status
FROM soldier S
JOIN soldiers_agg S1 ON
	S.brigade_id = S1.brigade_id
	AND S.created_date = S1.max_created_date
ORDER BY S.brigade_id, S.created_date DESC
;

-- Последний статус каждого бойца через Оконные функции (ROW_NUMBER)
SELECT *
FROM (
	SELECT *, ROW_NUMBER() OVER(PARTITION BY brigade_id, full_name ORDER BY created_date DESC) AS N
	FROM soldier 
) S
WHERE S.N = 1
;
-------------------------------------------------------------------------------------------------------






