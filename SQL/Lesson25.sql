-- Lesson 25: LEFT JOIN, COALESCE, BETWEEN, IN



SELECT A.id, A.ore_id, A.amount, A.price, O.ore_type, O.amount, O.price_per_kg 
FROM f_application A
INNER JOIN d_ore O ON
	A.ore_id = o.id
;


SELECT A.id, A.customer_id, A.amount, A.price, C.company_name, C.industry_area
FROM f_application A
INNER JOIN d_customers C ON
	A.customer_id = C.id 
;


SELECT A.id, A.miner_id, A.amount, A.price, M.company_name, M.email_address
FROM f_application A
INNER JOIN d_miners M ON
	A.miner_id = M.id 
;


SELECT M.id, M.company_name, E.id, E."name", E.surname, E.e_position 
FROM d_miners M
JOIN d_employee E ON
	M.id = E.miner_id 
;


SELECT A.id, A.customer_id, C.company_name, C.industry_area, A.miner_id, M.company_name, O.id, O.ore_type
FROM f_application A
INNER JOIN d_customers C ON
	A.customer_id = C.id 
JOIN d_miners M ON
	A.miner_id = M.id
INNER JOIN d_ore O ON
	A.ore_id = o.id
ORDER BY A.id
;


SELECT S.employee_id, E."name", E.surname, S.efficiency, S.salary 
FROM f_salary S
JOIN d_employee E ON
	S.employee_id = E.id
;


SELECT A.id, M.id AS miner_id, M.company_name 
FROM f_application A
LEFT JOIN d_miners M ON
	A.id = M.id 
;


SELECT A.id, C.id AS customer_id, C.industry_area 
FROM f_application A
LEFT JOIN d_customers C ON
	A.id = C.id 
;


SELECT A.id, C.id AS customer_id, C.industry_area, O.ore_type 
FROM f_application A
LEFT JOIN d_customers C ON
	A.id = C.id 
LEFT JOIN d_ore O ON
	A.ore_id = O.id
;


SELECT A.id, M.id AS miner_id, M.company_name, C.company_name, C.industry_area 
FROM f_application A
LEFT JOIN d_miners M ON
	A.id = M.id 
LEFT JOIN d_customers C ON
	M.id = C.id
;


SELECT M.id AS miner_id, M.company_name, E.id AS employee_id, COALESCE(E."name", 'Noname') AS e_name,
	   E.e_position, E.begin_date AS worker_begin_date, S.id AS salary_id, COALESCE(S.salary, NULL, 0, 90000.0)
FROM d_miners M
LEFT JOIN (
	SELECT *
	FROM d_employee
	WHERE
	begin_date BETWEEN '2022-02-01 08:00:00.000'::date::timestamp AND '2022-05-01 21:00:00.000'::date::timestamp
) E ON
	M.id = E.miner_id
LEFT JOIN f_salary S ON
	E.id = S.employee_id
ORDER BY M.id 
;



