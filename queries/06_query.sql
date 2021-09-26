/********************************
-- Question 6
The Pricing Team wants to know how each category performs according to their price range. 
In order to help them they asked you to provide them a list of categories with:

1. their category name
2. their price range as:
    “1.Below $20”
    “2. $20 - $50”
    “3. Over $50”
3. their total amount (formatted to be integer)
4. their number of orders

Finally order the results by category name then price range (both ascending order).
***********************************/

--Solution query
SELECT
	c.category_name,
	CASE 
		WHEN p.unit_price < 20 THEN '1. Below $20'
		WHEN p.unit_price >= 20 AND p.unit_price <= 50 THEN '2. $20 - $50'
		WHEN p.unit_price > 50 THEN '3. Over $50'
		END AS price_range,
	ROUND(SUM(d.unit_price * d.quantity)) AS total_amount,
	COUNT(DISTINCT d.order_id) AS total_number_orders
FROM categories AS c
INNER JOIN products AS p
ON c.category_id =  p.category_id
INNER JOIN order_details AS d
ON d.product_id =  p.product_id
GROUP BY 
	c.category_name,
	price_range
ORDER BY 
	c.category_name,
	price_range;