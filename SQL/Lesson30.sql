-- Lesson 30: Query plan, EXPLAIN ANALYZE, Full Table Scan, Index Scan, Bitmap Scan


-- 1) Full Table Scan (Seq scan)
EXPLAIN ANALYZE
SELECT *
FROM d_customers

/*
Seq Scan on d_customers  (cost=0.00..11.60 rows=160 width=474) (actual time=0.006..0.006 rows=5 loops=1)
Planning Time: 0.042 ms
Execution Time: 0.018 ms
*/

-- 2) Index Scan
EXPLAIN ANALYZE
SELECT *
FROM d_customers
WHERE
	id = 4

/*
Index Scan using d_customers_id_key on d_customers  (cost=0.14..8.16 rows=1 width=474) (actual time=0.009..0.010 rows=1 loops=1)
  Index Cond: (id = 4)
Planning Time: 0.143 ms
Execution Time: 0.035 ms
*/

-- 3) Full primary key
EXPLAIN ANALYZE
SELECT *
FROM d_customers
WHERE
	id = 4
	AND create_date BETWEEN '2022-04-01 00:00:00.000'::timestamp AND '2022-04-30 23:59:59.999'::timestamp
	
/*
Index Scan using d_customers_id_key on d_customers  (cost=0.14..8.17 rows=1 width=474) (actual time=0.035..0.038 rows=1 loops=1)
  Index Cond: (id = 4)
  Filter: ((create_date >= '2022-04-01 00:00:00'::timestamp without time zone) AND (create_date <= '2022-04-30 23:59:59.999'::timestamp without time zone))
Planning Time: 0.217 ms
Execution Time: 0.082 ms
*/
	
-- 4) Part primary key
EXPLAIN ANALYZE
SELECT *
FROM d_customers
WHERE
	create_date BETWEEN '2022-02-01 00:00:00.000'::timestamp AND '2022-04-30 23:59:59.999'::timestamp
	
/*
Seq Scan on d_customers  (cost=0.00..12.40 rows=1 width=474) (actual time=0.021..0.026 rows=3 loops=1)
  Filter: ((create_date >= '2022-02-01 00:00:00'::timestamp without time zone) AND (create_date <= '2022-04-30 23:59:59.999'::timestamp without time zone))
  Rows Removed by Filter: 2
Planning Time: 0.151 ms
Execution Time: 0.057 ms 
*/
	
-- 5) Type change timestamp to date (slower)
EXPLAIN ANALYZE
SELECT *
FROM d_customers
WHERE
	create_date::date >= '2022-04-01'
	
/*
Seq Scan on d_customers  (cost=0.00..12.40 rows=53 width=474) (actual time=0.010..0.011 rows=2 loops=1)
  Filter: ((create_date)::date >= '2022-04-01'::date)
  Rows Removed by Filter: 3
Planning Time: 0.047 ms
Execution Time: 0.024 ms
*/

-- Index on id, create_date (Bitmap Scan)
EXPLAIN ANALYZE
SELECT *
FROM f_application
WHERE
	id BETWEEN 4 AND 8 
	AND create_date BETWEEN '2022-06-01 00:00:00.000'::timestamp AND '2022-06-30 23:59:59.999'::timestamp
	
/*
Bitmap Heap Scan on f_application  (cost=4.22..14.42 rows=1 width=32) (actual time=0.025..0.031 rows=3 loops=1)
  Recheck Cond: ((id >= 4) AND (id <= 8))
  Filter: ((create_date >= '2022-06-01 00:00:00'::timestamp without time zone) AND (create_date <= '2022-06-30 23:59:59.999'::timestamp without time zone))
  Rows Removed by Filter: 2
  Heap Blocks: exact=1
  ->  Bitmap Index Scan on f_application_pkey  (cost=0.00..4.22 rows=7 width=0) (actual time=0.011..0.011 rows=5 loops=1)
        Index Cond: ((id >= 4) AND (id <= 8))
Planning Time: 0.220 ms
Execution Time: 0.078 ms
*/
		
-- Index with id, create_date (Seq Scan)
CREATE INDEX idx_f_application_create_date ON f_application (create_date);

EXPLAIN ANALYZE
SELECT *
FROM f_application
WHERE
	id BETWEEN 4 AND 8 
	AND create_date BETWEEN '2022-06-01 00:00:00.000'::timestamp AND '2022-06-30 23:59:59.999'::timestamp

/*
Seq Scan on f_application  (cost=0.00..1.20 rows=1 width=32) (actual time=0.013..0.016 rows=3 loops=1)
  Filter: ((id >= 4) AND (id <= 8) AND (create_date >= '2022-06-01 00:00:00'::timestamp without time zone) AND (create_date <= '2022-06-30 23:59:59.999'::timestamp without time zone))
  Rows Removed by Filter: 7
Planning Time: 0.369 ms
Execution Time: 0.037 ms
*/

-- Index on create_date only
EXPLAIN ANALYZE
SELECT *
FROM f_application
WHERE
	create_date BETWEEN '2022-03-05 00:00:00.000'::timestamp AND '2022-06-05 23:59:59.999'::timestamp
	
/*
Seq Scan on f_application  (cost=0.00..1.15 rows=1 width=32) (actual time=0.009..0.010 rows=1 loops=1)
  Filter: ((create_date >= '2022-06-05 00:00:00'::timestamp without time zone) AND (create_date <= '2022-06-05 23:59:59.999'::timestamp without time zone))
  Rows Removed by Filter: 9
Planning Time: 0.088 ms
Execution Time: 0.024 ms
*/

-- Scan on index (id, create_date)
CREATE INDEX idx_f_application_id_create_date ON f_application (id, create_date);

EXPLAIN ANALYZE
SELECT *
FROM f_application
WHERE
	id BETWEEN 4 AND 8 
	AND create_date BETWEEN '2022-06-01 00:00:00.000'::timestamp AND '2022-06-30 23:59:59.999'::timestamp

/*
Seq Scan on f_application  (cost=0.00..1.20 rows=1 width=32) (actual time=0.017..0.020 rows=3 loops=1)
  Filter: ((id >= 4) AND (id <= 8) AND (create_date >= '2022-06-01 00:00:00'::timestamp without time zone) AND (create_date <= '2022-06-30 23:59:59.999'::timestamp without time zone))
  Rows Removed by Filter: 7
Planning Time: 1.043 ms
Execution Time: 0.055 ms
*/
	
	

	