/********************************
-- Question 2
The Logistics Team wants to do a retrospection of their performances for the year 1998, 
in order to identify for which countries they didn’t perform well. They asked you to 
provide them a list of countries with the following information:

1. their average days between the order date and the shipping date (formatted to have only 2 decimals)
2. their total number of orders (based on the order date). Filtered on the following conditions:
	1. the year of order date is 1998
	2. their average days between the order date and the shipping date is greater or equal 5 days
	3. their total number of orders is greater than 10 orders

Finally order the results by country name in an ascending order (lowest first).
***********************************/

-- Solution Query
WITH cte_avg_days AS (
	SELECT
		ship_country,
		ROUND(AVG(
			EXTRACT(DAY FROM (shipped_date - order_date) * INTERVAL '1 DAY')
			)::NUMERIC,
		2) AS average_days_between_order_shipping,
		COUNT(*) AS total_number_orders
	FROM orders
	WHERE EXTRACT(YEAR FROM order_date) = 1998
	GROUP BY 
		ship_country
	ORDER BY ship_country
	)
SELECT * FROM cte_avg_days
WHERE average_days_between_order_shipping >= 5
AND total_number_orders > 10;

--Result
+─────────────────+────────────────────────────────────────+────────────────────────+
| "ship_country"  | "average_days_between_order_shipping"  | "total_number_orders"  |
+─────────────────+────────────────────────────────────────+────────────────────────+
| "Austria"       | "5.89"                                 | "11"                   |
| "Brazil"        | "8.12"                                 | "28"                   |
| "France"        | "9.43"                                 | "23"                   |
| "Germany"       | "5.38"                                 | "34"                   |
| "Spain"         | "7.83"                                 | "12"                   |
| "Sweden"        | "13.29"                                | "14"                   |
| "UK"            | "6.25"                                 | "16"                   |
| "USA"           | "7.89"                                 | "39"                   |
| "Venezuela"     | "8.73"                                 | "18"                   |
+─────────────────+────────────────────────────────────────+────────────────────────+