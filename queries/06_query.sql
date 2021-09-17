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
		WHEN p.unit_price < 20 THEN 'Below $20'
		WHEN p.unit_price >= 20 AND p.unit_price <= 50 THEN '$20 - $50'
		WHEN p.unit_price > 50 THEN 'Over $50'
		END AS price_range,
	SUM(p.unit_in_stock)::INT AS total_amount,
	SUM(unit_on_order) AS total_number_orders
FROM categories AS c
INNER JOIN products AS p
ON c.category_id =  p.category_id
GROUP BY 
	c.category_name,
	p.unit_price
ORDER BY 
	c.category_name,
	p.unit_price;

--Result
+──────────────────+────────────────+─────────────────+────────────────────────+
| "category_name"  | "price_range"  | "total_amount"  | "total_number_orders"  |
+──────────────────+────────────────+─────────────────+────────────────────────+
| "Beverages"      | "Below $20"    | 20              | "0"                    |
| "Beverages"      | "Below $20"    | 125             | "0"                    |
| "Beverages"      | "Below $20"    | 163             | "0"                    |
| "Beverages"      | "Below $20"    | 15              | "10"                   |
| "Beverages"      | "Below $20"    | 185             | "0"                    |
| "Beverages"      | "Below $20"    | 17              | "40"                   |
| "Beverages"      | "$20 - $50"    | 17              | "10"                   |
| "Beverages"      | "Over $50"     | 17              | "0"                    |
| "Condiments"     | "Below $20"    | 13              | "70"                   |
| "Condiments"     | "Below $20"    | 71              | "0"                    |
| "Condiments"     | "Below $20"    | 4               | "100"                  |
| "Condiments"     | "Below $20"    | 27              | "0"                    |
| "Condiments"     | "$20 - $50"    | 76              | "0"                    |
| "Condiments"     | "$20 - $50"    | 0               | "0"                    |
| "Condiments"     | "$20 - $50"    | 53              | "0"                    |
| "Condiments"     | "$20 - $50"    | 120             | "0"                    |
| "Condiments"     | "$20 - $50"    | 113             | "0"                    |
| "Condiments"     | "$20 - $50"    | 6               | "0"                    |
| "Condiments"     | "$20 - $50"    | 24              | "0"                    |
| "Confections"    | "Below $20"    | 25              | "0"                    |
| "Confections"    | "Below $20"    | 36              | "0"                    |
| "Confections"    | "Below $20"    | 3               | "40"                   |
| "Confections"    | "Below $20"    | 6               | "10"                   |
| "Confections"    | "Below $20"    | 15              | "70"                   |
| "Confections"    | "Below $20"    | 76              | "0"                    |
| "Confections"    | "Below $20"    | 65              | "0"                    |
| "Confections"    | "Below $20"    | 29              | "0"                    |
| "Confections"    | "$20 - $50"    | 10              | "60"                   |
| "Confections"    | "$20 - $50"    | 15              | "0"                    |
| "Confections"    | "$20 - $50"    | 49              | "0"                    |
| "Confections"    | "$20 - $50"    | 17              | "0"                    |
| "Confections"    | "Over $50"     | 40              | "0"                    |
| "Dairy Products" | "Below $20"    | 112             | "0"                    |
| "Dairy Products" | "Below $20"    | 0               | "70"                   |
| "Dairy Products" | "$20 - $50"    | 22              | "30"                   |
| "Dairy Products" | "$20 - $50"    | 26              | "0"                    |
| "Dairy Products" | "$20 - $50"    | 9               | "40"                   |
| "Dairy Products" | "$20 - $50"    | 19              | "0"                    |
| "Dairy Products" | "$20 - $50"    | 14              | "0"                    |
| "Dairy Products" | "$20 - $50"    | 26              | "0"                    |
| "Dairy Products" | "$20 - $50"    | 86              | "0"                    |
| "Dairy Products" | "Over $50"     | 79              | "0"                    |
| "Grains/Cereals" | "Below $20"    | 38              | "0"                    |
| "Grains/Cereals" | "Below $20"    | 61              | "0"                    |
| "Grains/Cereals" | "Below $20"    | 26              | "0"                    |
| "Grains/Cereals" | "Below $20"    | 36              | "0"                    |
| "Grains/Cereals" | "$20 - $50"    | 104             | "0"                    |
| "Grains/Cereals" | "$20 - $50"    | 22              | "80"                   |
| "Grains/Cereals" | "$20 - $50"    | 21              | "10"                   |
| "Meat/Poultry"   | "Below $20"    | 21              | "0"                    |
| "Meat/Poultry"   | "$20 - $50"    | 115             | "0"                    |
| "Meat/Poultry"   | "$20 - $50"    | 0               | "0"                    |
| "Meat/Poultry"   | "$20 - $50"    | 0               | "0"                    |
| "Meat/Poultry"   | "Over $50"     | 29              | "0"                    |
| "Meat/Poultry"   | "Over $50"     | 0               | "0"                    |
| "Produce"        | "Below $20"    | 4               | "20"                   |
| "Produce"        | "$20 - $50"    | 35              | "0"                    |
| "Produce"        | "$20 - $50"    | 15              | "0"                    |
| "Produce"        | "$20 - $50"    | 26              | "0"                    |
| "Produce"        | "Over $50"     | 20              | "0"                    |
| "Seafood"        | "Below $20"    | 24              | "0"                    |
| "Seafood"        | "Below $20"    | 5               | "70"                   |
| "Seafood"        | "Below $20"    | 85              | "0"                    |
| "Seafood"        | "Below $20"    | 95              | "0"                    |
| "Seafood"        | "Below $20"    | 62              | "0"                    |
| "Seafood"        | "Below $20"    | 101             | "0"                    |
| "Seafood"        | "Below $20"    | 123             | "0"                    |
| "Seafood"        | "Below $20"    | 112             | "0"                    |
| "Seafood"        | "$20 - $50"    | 10              | "0"                    |
| "Seafood"        | "$20 - $50"    | 11              | "50"                   |
| "Seafood"        | "$20 - $50"    | 31              | "0"                    |
| "Seafood"        | "Over $50"     | 42              | "0"                    |
+──────────────────+────────────────+─────────────────+────────────────────────+

