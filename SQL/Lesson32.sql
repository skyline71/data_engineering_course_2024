-- Lesson 32: CASE WHEN, READ FROM CSV




CREATE TABLE input_table (
	"unix" varchar(100),
	"date" varchar(100),
	"symbol" varchar(100),
	"open" varchar(100),
	"high" varchar(100),
	"low" varchar(100),
	"close" varchar(100),
	"Volume BTC" varchar(100),
	"Volume USD" varchar(100)
)
;


-- ALTER ROLE test_user WITH SUPERUSER;


COPY input_table
FROM '/tmp/Bitstamp_BTCUSD_d.csv'
DELIMITER ','
CSV HEADER;


SELECT *
FROM input_table
;


CREATE TABLE main_table (
	id serial,
	unix_code varchar(100),
	trade_date timestamp,
	symbol varchar(100),
	"open" float,
	high float,
	low float,
	"close" float,
	volume_btc float,
	volume_usd float
)
;


INSERT INTO main_table (unix_code, trade_date, symbol, "open", high, low, "close", volume_btc, volume_usd)
SELECT
	CASE
		WHEN unix = '' THEN NULL
		ELSE unix
	END AS unix_code,
	CASE
		WHEN "date" = '' THEN NULL
		ELSE "date"::timestamp
	END AS trade_date,
	CASE
		WHEN symbol = '' THEN NULL
		ELSE symbol
	END AS symbol,
	CASE
		WHEN "open" = '' THEN NULL
		ELSE "open"::float
	END AS "open",
	CASE
		WHEN high = '' THEN NULL
		ELSE high::float
	END AS high,
	CASE
		WHEN low = '' THEN NULL
		ELSE low::float
	END AS low,
	CASE
		WHEN "close" = '' THEN NULL
		ELSE "close"::float
	END AS "close",
	CASE
		WHEN "Volume BTC" = '' THEN NULL
		ELSE "Volume BTC"::float
	END AS volume_btc,
	CASE
		WHEN "Volume USD" = '' THEN NULL
		ELSE "Volume USD"::float
	END AS volume_usd
FROM input_table
;

SELECT *
FROM main_table



SELECT trade_year, MIN("open") AS min_open, MAX("close") AS max_close, AVG(volume_btc) AS avg_btc
FROM (
	SELECT *, EXTRACT(YEAR FROM trade_date) AS trade_year
	FROM main_table
) trades
GROUP BY trade_year
ORDER BY 1
;



WITH btc_filtered AS (
	SELECT *, 
	CASE
		WHEN volume_btc > 10000 THEN 0
		ELSE volume_btc
	END AS volume_btc_filtered
	FROM (
		SELECT *, EXTRACT(YEAR FROM trade_date) AS trade_year
		FROM main_table
	) trades
)
SELECT trade_year, AVG(volume_btc) AS avg_btc, AVG(volume_btc_filtered) AS avg_btc_filtered
FROM btc_filtered
GROUP BY trade_year
ORDER BY 1
;


SELECT trade_year, MIN("open") AS min_open, MAX("close") AS max_close, SUM(volume_usd)/
	   (SELECT SUM(volume_usd) AS usd_sum FROM main_table) AS usd_part
FROM (
	SELECT *, EXTRACT(YEAR FROM trade_date) AS trade_year
	FROM main_table
) trades
GROUP BY trade_year
ORDER BY usd_part DESC
;




