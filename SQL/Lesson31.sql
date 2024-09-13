-- Lesson 31: JOIN:HASH JOIN, MERGE JOIN, NESTED LOOPS


EXPLAIN ANALYZE
SELECT *
FROM f_application F
JOIN f_application F1 ON
	F.id = F1.id
	
/*
Hash Join  (cost=1.23..2.36 rows=10 width=64) (actual time=0.057..0.063 rows=10 loops=1)
  Hash Cond: (f.id = f1.id)
  ->  Seq Scan on f_application f  (cost=0.00..1.10 rows=10 width=32) (actual time=0.016..0.017 rows=10 loops=1)
  ->  Hash  (cost=1.10..1.10 rows=10 width=32) (actual time=0.027..0.028 rows=10 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        ->  Seq Scan on f_application f1  (cost=0.00..1.10 rows=10 width=32) (actual time=0.002..0.003 rows=10 loops=1)
Planning Time: 9.410 ms
Execution Time: 0.127 ms  
*/
	
	
EXPLAIN ANALYZE
SELECT *
FROM d_ore O
JOIN f_application A ON
	O.id = A.ore_id
	
	
/*
Hash Join  (cost=1.23..15.59 rows=10 width=262) (actual time=0.130..0.142 rows=10 loops=1)
  Hash Cond: (o.id = a.ore_id)
  ->  Seq Scan on d_ore o  (cost=0.00..13.10 rows=310 width=230) (actual time=0.024..0.026 rows=5 loops=1)
  ->  Hash  (cost=1.10..1.10 rows=10 width=32) (actual time=0.078..0.079 rows=10 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        ->  Seq Scan on f_application a  (cost=0.00..1.10 rows=10 width=32) (actual time=0.007..0.010 rows=10 loops=1)
Planning Time: 6.395 ms
Execution Time: 0.252 ms
*/
	

EXPLAIN ANALYZE
SELECT *
FROM d_customers C
JOIN f_application A ON
	C.id = A.customer_id
JOIN d_miners M ON
	A.miner_id = M.id
	

/*
Hash Join  (cost=13.65..26.09 rows=10 width=938) (actual time=2.243..2.268 rows=10 loops=1)
  Hash Cond: (m.id = a.miner_id)
  ->  Seq Scan on d_miners m  (cost=0.00..11.70 rows=170 width=432) (actual time=2.047..2.051 rows=5 loops=1)
  ->  Hash  (cost=13.52..13.52 rows=10 width=506) (actual time=0.146..0.150 rows=10 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 10kB
        ->  Hash Join  (cost=1.23..13.52 rows=10 width=506) (actual time=0.088..0.113 rows=10 loops=1)
              Hash Cond: (c.id = a.customer_id)
              ->  Seq Scan on d_customers c  (cost=0.00..11.60 rows=160 width=474) (actual time=0.014..0.018 rows=5 loops=1)
              ->  Hash  (cost=1.10..1.10 rows=10 width=32) (actual time=0.039..0.041 rows=10 loops=1)
                    Buckets: 1024  Batches: 1  Memory Usage: 9kB
                    ->  Seq Scan on f_application a  (cost=0.00..1.10 rows=10 width=32) (actual time=0.010..0.015 rows=10 loops=1)
Planning Time: 14.502 ms
Execution Time: 2.408 ms
*/
	

EXPLAIN ANALYZE
SELECT *
FROM d_customers C
JOIN d_customers C1 ON
	C.id = C1.id
	

/*
Hash Join  (cost=13.60..25.63 rows=160 width=948) (actual time=0.197..0.211 rows=5 loops=1)
  Hash Cond: (c.id = c1.id)
  ->  Seq Scan on d_customers c  (cost=0.00..11.60 rows=160 width=474) (actual time=0.019..0.023 rows=5 loops=1)
  ->  Hash  (cost=11.60..11.60 rows=160 width=474) (actual time=0.016..0.018 rows=5 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        ->  Seq Scan on d_customers c1  (cost=0.00..11.60 rows=160 width=474) (actual time=0.004..0.007 rows=5 loops=1)
Planning Time: 0.549 ms
Execution Time: 0.306 ms
*/
	
	
EXPLAIN ANALYZE
SELECT *
FROM d_miners M
JOIN f_application A ON
	M.id = A.miner_id
WHERE
	A.create_date BETWEEN '2022-04-01 00:00:00.000'::timestamp AND '2022-04-30 23:59:59.999'::timestamp
	

/*
Nested Loop  (cost=0.14..9.41 rows=1 width=464) (actual time=0.034..0.036 rows=0 loops=1)
  ->  Seq Scan on f_application a  (cost=0.00..1.15 rows=1 width=32) (actual time=0.033..0.033 rows=0 loops=1)
        Filter: ((create_date >= '2022-04-01 00:00:00'::timestamp without time zone) AND (create_date <= '2022-04-30 23:59:59.999'::timestamp without time zone))
        Rows Removed by Filter: 10
  ->  Index Scan using d_miners_id_key on d_miners m  (cost=0.14..8.16 rows=1 width=432) (never executed)
        Index Cond: (id = a.miner_id)
Planning Time: 5.922 ms
Execution Time: 0.137 ms
*/


EXPLAIN ANALYZE
SELECT *
FROM d_miners M
JOIN (SELECT * FROM f_application ORDER BY id) A ON
	M.id = A.miner_id
WHERE
	A.create_date BETWEEN '2022-04-01 00:00:00.000'::timestamp AND '2022-04-30 23:59:59.999'::timestamp
	
	
/*
Nested Loop  (cost=1.30..9.43 rows=1 width=464) (actual time=0.017..0.017 rows=0 loops=1)
  ->  Sort  (cost=1.16..1.16 rows=1 width=32) (actual time=0.016..0.017 rows=0 loops=1)
        Sort Key: f_application.id
        Sort Method: quicksort  Memory: 25kB
        ->  Seq Scan on f_application  (cost=0.00..1.15 rows=1 width=32) (actual time=0.012..0.013 rows=0 loops=1)
              Filter: ((create_date >= '2022-04-01 00:00:00'::timestamp without time zone) AND (create_date <= '2022-04-30 23:59:59.999'::timestamp without time zone))
              Rows Removed by Filter: 10
  ->  Index Scan using d_miners_id_key on d_miners m  (cost=0.14..8.16 rows=1 width=432) (never executed)
        Index Cond: (id = f_application.miner_id)
Planning Time: 0.159 ms
Execution Time: 0.046 ms
*/
	
	
	
