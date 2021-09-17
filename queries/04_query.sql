/********************************
-- Question 4
The Logistics Team wants to do a retrospection of their global performances over 1997-1998, 
in order to identify for which month they perform well. They asked you to provide them a list with:

1. their year/month as single field in a date format (e.g. “1996-01-01” January 1996)
2. their total number of orders
3. their total freight (formatted to have no decimals)

Filtered on the following conditions:
1. the order date is between 1997 and 1998
2. their total number of orders is greater than 35 orders 

Finally order the results by total freight (descending order).
***********************************/

-- Solution Query
WITH cte_freight AS ( 
	SELECT
		required_date AS year_month,
		COUNT(*) AS total_number_orders,
		ROUND(
			SUM(freight)
			)::INT AS total_freight
	FROM orders
	GROUP BY required_date
	)
SELECT * FROM cte_freight
WHERE EXTRACT(YEAR FROM year_month) BETWEEN 1997 AND 1998
AND total_number_orders > 35
ORDER BY total_freight DESC;

--Result
