
/*Quantidade de cadastros realizados*/
SELECT COUNT(*) FROM users;
/*GRAFANA*/
SELECT COUNT(*) AS Users, now() as time FROM users;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de cadastros deletados*/
SELECT COUNT(*) FROM users WHERE deletedAt IS NOT NULL;
/*GRAFANA*/
SELECT COUNT(*) AS Users, NOW() AS time FROM users WHERE deletedAt IS NOT NULL;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de cadastros ativos*/
SELECT COUNT(*) FROM users WHERE active = 'yes';
/*GRAFANA*/
SELECT COUNT(*) AS Users, NOW() AS time FROM users WHERE active = 'yes';

---------------------------------------------------------------------------------------------------------------

/*Quantidade de cadastros inativos*/
SELECT COUNT(*) FROM users WHERE active = 'no';
/*GRAFANA*/
SELECT COUNT(*) AS Users, NOW() AS time FROM users WHERE active = 'no';

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras no total geral*/
SELECT COUNT(*) FROM purchases;
/*GRAFANA*/
SELECT COUNT(*) AS Purchases, now() as time FROM users;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras nos ultimos 12 meses*/
SELECT 
	COUNT(*),
	(NOW() - INTERVAL 1 YEAR) AS _FROM_,
	(NOW()) as _TO_
FROM 
	purchases 
WHERE
	createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW());
/*GRAFANA*/
SELECT 
	COUNT(*) AS Purchases, 
	(NOW()) as time,
	(NOW() - INTERVAL 1 YEAR) AS _FROM_,
	(NOW()) as _TO_
FROM 
	purchases 
WHERE
	createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW());

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras nos ultimos 3 anos (contabilizadas por ano: ano1=200, ano2=100, ano3=500)*/
SELECT
	COUNT(*) AS TOTAL,
	(SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 3 YEAR)) AND ((NOW() - INTERVAL 2 YEAR))
	) AS YEAR1,
	(SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 2 YEAR)) AND ((NOW() - INTERVAL 1 YEAR))
	) AS YEAR2,
	(SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
	) AS YEAR3
FROM
	purchases
WHERE
	createdAt IS NOT NULL;
/*GRAFANA*/
SELECT
	(NOW()) as time,
	(
	SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 3 YEAR)) AND ((NOW() - INTERVAL 2 YEAR))
	) AS '2020',
	(
	SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 2 YEAR)) AND ((NOW() - INTERVAL 1 YEAR))
	) AS '2021',
	(
	SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
	) AS '2022'
FROM
	purchases
WHERE
	createdAt IS NOT NULL;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras canceladas*/
SELECT * FROM purchases WHERE deletedAt IS NOT NULL;
/*GRAFANA*/
SELECT COUNT(*) AS Purchases, now() as time FROM purchases WHERE deletedAt IS NOT NULL;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras canceladas nos ultimos 12 meses*/
SELECT 
	COUNT(*),
	(NOW() - INTERVAL 1 YEAR) AS _FROM_,
	(NOW()) as _TO_
FROM 
	purchases 
WHERE
	createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
	AND deletedAt IS NOT NULL;
/*GRAFANA*/
SELECT 
	COUNT(*) As Purchases,
	(NOW()) as time,
	(NOW() - INTERVAL 1 YEAR) AS _FROM_,
	(NOW()) as _TO_
FROM 
	purchases 
WHERE
	createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
	AND deletedAt IS NOT NULL;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras canceladas nos ultimos 3 anos (contabilizadas por ano: ano1=200, ano2=100, ano3=500)*/
SELECT
	COUNT(*) AS TOTAL,
	(
	SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 3 YEAR)) AND ((NOW() - INTERVAL 2 YEAR))
		AND deletedAt IS NOT NULL
	) AS YEAR1,
	(
	SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 2 YEAR)) AND ((NOW() - INTERVAL 1 YEAR))
		AND deletedAt IS NOT NULL
	) AS YEAR2,
	(
	SELECT 
		COUNT(*)
	FROM 
		purchases 
	WHERE
		createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
		AND deletedAt IS NOT NULL
	) AS YEAR3
FROM
	purchases
WHERE
	deletedAt IS NOT NULL;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de produtos vendidos (12 meses)*/
SELECT 
	SUM(quantity) AS TOTAL
FROM
	purchases
WHERE
	createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW());

---------------------------------------------------------------------------------------------------------------

/*Quantidade de cadastros sem compras*/
SELECT
	COUNT(u.id)
FROM
	users u
WHERE
	u.id NOT IN (SELECT user_id  FROM purchases);

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras feitas pelo APP*/
SELECT COUNT(*) FROM purchases p WHERE origin = 'app';

---------------------------------------------------------------------------------------------------------------

/*Quantidade de compras feitas pelo Website*/
SELECT COUNT(*) FROM purchases p WHERE origin = 'website';

---------------------------------------------------------------------------------------------------------------

/*Percentual de compras feitas pelo App x Website*/
SELECT 
	COUNT(*) AS _Total_,
	(SELECT COUNT(*) FROM purchases p WHERE origin = 'app') AS _App_,
	(SELECT COUNT(*) FROM purchases p WHERE origin = 'website') AS _Website_,
	CONCAT(FORMAT((((SELECT COUNT(*) FROM purchases p WHERE origin = 'app') / COUNT(*)) * 100), 2), '%') AS _App_Percent_,
	CONCAT(FORMAT((((SELECT COUNT(*) FROM purchases p WHERE origin = 'website') / COUNT(*)) * 100), 2), '%') AS _Website_Percent_
FROM 
	purchases
WHERE
	createdAt IS NOT NULL;

---------------------------------------------------------------------------------------------------------------

/*Percentual de compras feitas pelo App x Website no ultimos 12 meses*/
SELECT 
	COUNT(*) AS _Total_,
	(SELECT COUNT(*) FROM purchases p WHERE origin = 'app' AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) AS _App_,
	(SELECT COUNT(*) FROM purchases p WHERE origin = 'website' AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) AS _Website_,
	CONCAT(FORMAT((((SELECT COUNT(*) FROM purchases p WHERE origin = 'app' AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) / COUNT(*)) * 100), 2), '%') AS _App_Percent_,
	CONCAT(FORMAT((((SELECT COUNT(*) FROM purchases p WHERE origin = 'website' AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) / COUNT(*)) * 100), 2), '%') AS _Website_Percent_
FROM 
	purchases
WHERE
	createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW());

---------------------------------------------------------------------------------------------------------------

/*Percentual de compras dos ultimos 12 meses (mes a mes)*/
SELECT
	DATE_FORMAT(createdAt, '%m') AS _MonthNumber_,
	SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) AS _Month_,
	DATE_FORMAT(createdAt , '%Y') AS _Year_,
	COUNT(id) AS _Quantity_,
	CONCAT(FORMAT(((COUNT(id) / (SELECT COUNT(*) FROM purchases WHERE createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW()))) * 100), 2), '%') AS _Percentage_
FROM 
	purchases
WHERE 
	createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
GROUP BY
	_MonthNumber_, _Year_, _Month_
ORDER BY 
	_Year_, _MonthNumber_;

---------------------------------------------------------------------------------------------------------------

/*Media de compras referente aos 12 ultimos meses*/
SELECT _Average_ FROM(
	SELECT
		(SELECT COUNT(*) FROM purchases WHERE createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) AS _Total_,
		SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) AS _Month_,
		DATE_FORMAT(createdAt , '%Y') AS _Year_,
		COUNT(id) AS _Quantity_,
		FORMAT((SELECT COUNT(*) FROM purchases WHERE createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) / (SELECT COUNT(_COUNTER_) FROM (
			SELECT COUNT(*) AS _COUNTER_, SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) AS _M_ FROM purchases WHERE createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW()) GROUP BY _M_
		) AS _VIRTUAL_), 0) AS _Average_
	FROM 
		purchases
	WHERE 
		createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
	GROUP BY
		_Month_, _Year_
) AS _Average_Calc_
GROUP BY _Average_;

---------------------------------------------------------------------------------------------------------------

/*Quantidade de cadastros realizados nos ultimos 12 meses separados por origin (app, website) mes a mes*/

/*Helpers*/
SELECT * FROM purchases WHERE origin = 'app' AND createdAt BETWEEN '2021-01-01 00:00:00' AND '2021-01-31 00:00:00';
SELECT * FROM purchases WHERE origin = 'website' AND createdAt BETWEEN '2021-04-01 00:00:00' AND '2021-04-31 00:00:00';
SELECT COUNT(*) FROM purchases WHERE origin = 'app' AND createdAt BETWEEN '2022-05-01 00:00:00' AND '2022-05-31 00:00:00';
SELECT COUNT(*) FROM purchases WHERE origin = 'website' AND createdAt BETWEEN '2021-04-01 00:00:00' AND '2021-04-31 00:00:00';

/*BKP*/
-- SELECT 
-- 	DATE_FORMAT(createdAt, '%m') AS _MonthNumber_,
-- 	SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) AS _Month_,
-- 	DATE_FORMAT(createdAt, '%Y') AS _Year_,
-- 	(SELECT COUNT(id) FROM purchases WHERE origin = 'app' AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) AS _App_,
-- 	(SELECT COUNT(id) FROM purchases WHERE origin = 'website' AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())) AS _Website_,
-- 	COUNT(*) AS _Count_
-- FROM 
-- 	purchases
-- WHERE
-- 	origin IN('app', 'website')	AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
-- GROUP BY
-- 	createdAt;

/*v1.0 [DONE]*/
SELECT 
	DATE_FORMAT(createdAt, '%m') AS _MonthNumber_,
	SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) AS _Month_,
	DATE_FORMAT(createdAt, '%Y') AS _Year_,
	origin AS _Origin_,
	COUNT(*) AS _Count_
FROM
	purchases 
WHERE
	origin IN('app', 'website') AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND NOW()
GROUP BY
	_Origin_, _MonthNumber_, _Year_, _Month_
ORDER BY
	_Year_, _MonthNumber_, _Month_;

/*BKP*/
SELECT 
	DATE_FORMAT(createdAt, '%m') AS _MonthNumber_,
	SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) AS _Month_,
	DATE_FORMAT(createdAt, '%Y') AS _Year_,
	IF((SELECT COUNT(id) FROM purchases WHERE origin = 'app' AND SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) = _Month_ AND DATE_FORMAT(createdAt, '%Y') = _Year_) > 0, 
		(SELECT COUNT(id) FROM purchases WHERE origin = 'app' AND SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) = _Month_ AND DATE_FORMAT(createdAt, '%Y') = _Year_), '0') AS _App_,
	IF((SELECT COUNT(id) FROM purchases WHERE origin = 'website' AND SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) = _Month_ AND DATE_FORMAT(createdAt, '%Y') = _Year_), 
		(SELECT COUNT(id) FROM purchases WHERE origin = 'app' AND SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) = _Month_ AND DATE_FORMAT(createdAt, '%Y') = _Year_), '0') AS _Website_
FROM
	purchases 
WHERE
	origin IN('app', 'website') AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND NOW()
-- GROUP BY
-- 	_Month_, _Year_
ORDER BY
	_Year_, _MonthNumber_;

/*v1.1 [WORK]*/
SELECT 
  	-- UNIX_TIMESTAMP(createdAt) as time_sec,
	DATE_FORMAT(createdAt, '%m') AS MonthNumber,
	SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) AS Month,
	DATE_FORMAT(createdAt, '%Y') AS Year,
	CONCAT(SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3), '/' , DATE_FORMAT(createdAt, '%Y')) AS MonthYear,
	(SELECT COUNT(id) FROM purchases WHERE origin = 'app' AND SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) = Month AND DATE_FORMAT(createdAt, '%Y') = Year) AS App,
	(SELECT COUNT(id) FROM purchases WHERE origin = 'website' AND SUBSTR(DATE_FORMAT(createdAt, '%M'), 1, 3) = Month AND DATE_FORMAT(createdAt, '%Y') = Year) AS Website
FROM
	purchases 
WHERE
	origin IN('app', 'website') AND createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND NOW()
GROUP BY
	MonthNumber, Year, Month, MonthYear
ORDER BY
	Year, MonthNumber, Month;



###############################################################################################################
# Tests
# 
# This not work in GRAFANA (not supported)
#

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SET @YEAR1 = DATE_FORMAT(((NOW() - INTERVAL 2 YEAR)), '%Y');
SET @YEAR2 = DATE_FORMAT(((NOW() - INTERVAL 1 YEAR)), '%Y');
SET @YEAR3 = DATE_FORMAT((NOW()), '%Y');

SET @query = CONCAT(" 
	SELECT
		(NOW()) as time,
		(
		SELECT 
			COUNT(*)
		FROM 
			purchases 
		WHERE
			createdAt BETWEEN ((NOW() - INTERVAL 3 YEAR)) AND ((NOW() - INTERVAL 2 YEAR))
		) AS '",@YEAR1,"',
		(
		SELECT 
			COUNT(*)
		FROM 
			purchases 
		WHERE
			createdAt BETWEEN ((NOW() - INTERVAL 2 YEAR)) AND ((NOW() - INTERVAL 1 YEAR))
		) AS '",@YEAR2,"',
		(
		SELECT 
			COUNT(*)
		FROM 
			purchases 
		WHERE
			createdAt BETWEEN ((NOW() - INTERVAL 1 YEAR)) AND (NOW())
		) AS '",@YEAR3,"'
	FROM
		purchases
	WHERE
		createdAt IS NOT NULL;");
	
PREPARE _statement FROM @query;
EXECUTE _statement;

/*GRAFANA SAMPLE*/
SELECT 
	UNIX_TIMESTAMP(createdAt) as time_sec,
	CASE
		WHEN month(createdAt) = 1 THEN 'Janeiro'
		WHEN month(createdAt) = 2 THEN 'Fevereiro'
		WHEN month(createdAt) = 3 THEN 'Março'
		WHEN month(createdAt) = 4 THEN 'Abril'
		WHEN month(createdAt) = 5 THEN 'Maio'
		WHEN month(createdAt) = 6 THEN 'Junho'
		WHEN month(createdAt) = 7 THEN 'Julho'
		WHEN month(createdAt) = 8 THEN 'Agosto'
		WHEN month(createdAt) = 9 THEN 'Setembro'
		WHEN month(createdAt) = 10 THEN 'Outubro'
		WHEN month(createdAt) = 11 THEN 'Novembro'
		WHEN month(createdAt) = 12 THEN 'Dezembro'
	ELSE 
		'Indefinido'
	END as metric,
	count(month(createdAt)) as value
FROM
	users
GROUP BY 1,2;

