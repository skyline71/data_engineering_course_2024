-- Lesson 24: INNER JOIN



CREATE TABLE d_worker (
	id serial,
	full_name varchar(100),
	worker_section int DEFAULT 0,
	PRIMARY KEY (id)
);


CREATE TABLE d_section (
	id int,
	section_info varchar(50),
	PRIMARY KEY (id)
);


CREATE TABLE d_job (
	id int,
	job_info varchar(100),
	PRIMARY KEY (id)
);

SELECT *
FROM d_worker;

SELECT *
FROM d_section;

SELECT *
FROM d_job;


INSERT INTO d_worker (full_name, worker_section)
SELECT 'Denis' AS full_name, 1 AS worker_section
UNION ALL
SELECT 'Alexey' AS full_name, 2 AS worker_section
UNION ALL
SELECT 'Pavel' AS full_name, 3 AS worker_section
UNION ALL
SELECT 'Mark' AS full_name, 3 AS worker_section
;

INSERT INTO d_worker (full_name, worker_section)
SELECT 'Isaak' AS full_name, 4 AS worker_section
UNION ALL
SELECT 'Steven' AS full_name, 5 AS worker_section
;


INSERT INTO d_section (id, section_info)
SELECT 1 AS id, 'Programming' AS section_info
UNION ALL
SELECT 2 AS id, 'Testing' AS section_info
UNION ALL
SELECT 3 AS id, 'Marketing' AS section_info
;


INSERT INTO d_job (id, job_info)
SELECT 1 AS id, 'Backend' AS job_info
UNION ALL
SELECT 2 AS id, 'Analyst' AS job_info
UNION ALL
SELECT 3 AS id, 'Manager' AS job_info
UNION ALL
SELECT 4 AS id, 'Lead' AS job_info
;


INSERT INTO d_job (id, job_info)
SELECT 7 AS id, 'Frontend' AS job_info
UNION ALL
SELECT 8 AS id, 'Tester' AS job_info
;


SELECT W.full_name, S.section_info
FROM d_worker W
JOIN d_section S ON
	W.worker_section = S.id
;


SELECT W.full_name, S.section_info
FROM d_worker W
JOIN d_section S ON
	1 = 1
;


SELECT S.section_info, J.job_info
FROM d_section S
INNER JOIN d_job J ON
	S.id = J.id 
;


SELECT S.section_info, J.job_info
FROM d_section S
RIGHT JOIN d_job J ON
	S.id = J.id 
;


SELECT S.section_info, J.job_info
FROM d_section S
RIGHT OUTER JOIN d_job J ON
	S.id = J.id 
;


SELECT *
FROM d_worker W
JOIN d_section S ON
	W.worker_section = S.id
JOIN d_job J ON
	S.id = J.id
;


SELECT *
FROM d_worker W
JOIN d_section S ON
	W.worker_section = S.id
JOIN d_job J ON
	W.id = J.id
;


SELECT W.full_name, S.section_info, J.job_info 
FROM d_worker W
JOIN d_section S ON
	W.worker_section = S.id
JOIN d_job J ON
	W.id = J.id
;

SELECT *
FROM d_worker W
LEFT OUTER JOIN d_section S ON
	W.worker_section = S.id 
;


SELECT *
FROM d_job J
LEFT JOIN d_section S ON
	J.id = S.id 
;


SELECT *
FROM d_job J
LEFT JOIN d_worker W ON
	J.id = W.worker_section 
;


SELECT *
FROM d_worker W
LEFT JOIN d_section S ON
	W.worker_section = S.id
JOIN d_job J ON
	W.id = J.id 
;


SELECT *
FROM d_worker W
LEFT JOIN d_section S ON
	W.worker_section = S.id
LEFT JOIN d_job J ON
	W.id = J.id 
;


SELECT *
FROM d_worker W
LEFT JOIN d_section S ON
	W.worker_section = S.id
FULL JOIN d_job J ON
	W.id = J.id 
;




