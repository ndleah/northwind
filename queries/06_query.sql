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

--Result
+──────────────────+────────────────+─────────────────+────────────────────────+
| "category_name"  | "price_range"  | "total_amount"  | "total_number_orders"  |
+──────────────────+────────────────+─────────────────+────────────────────────+
| "Beverages"      | "1. Below $20" | 111464          | 317                    |
| "Beverages"      | "2. $20 - $50" | 25079           | 28                     |
| "Beverages"      | "3. Over $50"  | 149984          | 24                     |
| "Condiments"     | "1. Below $20" | 28622           | 85                     |
| "Condiments"     | "2. $20 - $50" | 85073           | 121                    |
| "Confections"    | "1. Below $20" | 57369           | 197                    |
| "Confections"    | "2. $20 - $50" | 96094           | 106                    |
| "Confections"    | "3. Over $50"  | 23636           | 16                     |
| "Dairy Products" | "1. Below $20" | 17886           | 81                     |
| "Dairy Products" | "2. $20 - $50" | 157148          | 204                    |
| "Dairy Products" | "3. Over $50"  | 76296           | 54                     |
| "Grains/Cereals" | "1. Below $20" | 25364           | 99                     |
| "Grains/Cereals" | "2. $20 - $50" | 75363           | 91                     |
| "Meat/Poultry"   | "1. Below $20" | 5121            | 36                     |
| "Meat/Poultry"   | "2. $20 - $50" | 76504           | 96                     |
| "Meat/Poultry"   | "3. Over $50"  | 96563           | 36                     |
| "Produce"        | "1. Below $20" | 2566            | 13                     |
| "Produce"        | "2. $20 - $50" | 57960           | 81                     |
| "Produce"        | "3. Over $50"  | 44743           | 39                     |
| "Seafood"        | "1. Below $20" | 69673           | 217                    |
| "Seafood"        | "2. $20 - $50" | 39963           | 70                     |
| "Seafood"        | "3. Over $50"  | 31988           | 27                     |
+──────────────────+────────────────+─────────────────+────────────────────────+