/********************************
-- Question 5
The Pricing Team wants to know which products had an unit price increase and 
the percentage increase was not between 20% and 30%. In order to help them they 
asked you to provide them a list of products with:

1. their product name
2. their current unit price (formatted to have only 2 decimals)
3. their previous unit price (formatted to have only 2 decimals)
4. their percentage increase as:
(New Number - Original Number) ÷ Original Number × 100 
(with the result formatted to an integer, e.g 50 for 50%)

Filtered on the following conditions:

1. their percentage increase is not between 20% and 30%
2. their total number of orders is greater than 10 orders
Finally order the results by percentage increase (ascending order).
***********************************/

-- Solution Query
WITH cte_price AS (
SELECT
	d.product_id,
	p.product_name,
	LEAD(d.unit_price) OVER (PARTITION BY p.product_name ORDER BY o.order_date) AS current_price,
	LAG(d.unit_price) OVER (PARTITION BY p.product_name ORDER BY o.order_date) AS previous_unit_price
FROM products AS p
INNER JOIN order_details AS d
ON p.product_id = d.product_id
INNER JOIN orders AS o
ON d.order_id = o.order_id
)
SELECT
	c.product_name,
	c.current_price,
	c.previous_unit_price,
	ROUND(100*(c.current_price - c.previous_unit_price)/c.previous_unit_price) AS percentage_increase
FROM cte_price AS c
INNER JOIN order_details AS d
ON c.product_id = d.product_id
WHERE c.current_price != c.previous_unit_price
GROUP BY 
	c.product_name,
	c.current_price,
	c.previous_unit_price
HAVING COUNT(DISTINCT d.order_id) > 10
AND ROUND(100*(c.current_price - c.previous_unit_price)/c.previous_unit_price) NOT BETWEEN 20 AND 30;

--Result:
+──────────────────────────────────+──────────────────+────────────────────────+────────────────────────+
| "product_name"                   | "current_price"  | "previous_unit_price"  | "percentage_increase"  |
+──────────────────────────────────+──────────────────+────────────────────────+────────────────────────+
| "Mozzarella di Giovanni"         | 27.8             | 34.8                   | -20                    |
| "Singaporean Hokkien Fried Mee"  | 11.2             | 9.8                    | 14                     |
+──────────────────────────────────+──────────────────+────────────────────────+────────────────────────+
