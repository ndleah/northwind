/********************************
-- Question 7
The Logistics Team wants to know what is the current state of our regional 
suppliers' stocks for each category of product. In order to help them they 
asked you to provide them a list of categories with:

1. their supplier region” as: 
   * “America”
   * “Europe”
   * “Asia-Pacific”
2. their category name
3. their total units in stock
4. their total units on order
5. heir total reorder level

Finally order the results by supplier region then category name then price range 
(each in ascending order).
***********************************/

--Solution query
SELECT
	c.category_name,
	CASE
		WHEN s.country IN ('Australia', 'Singapore', 'Japan' ) THEN 'Asia-Pacific'
		WHEN s.country IN ('US', 'Brazil', 'Canada') THEN 'America'
		ELSE 'Europe'
	END AS supplier_region,
	p.unit_in_stock AS units_in_stock,
	p.unit_on_order AS units_on_order,
	p.reorder_level 
FROM suppliers AS s
INNER JOIN products AS p
ON s.supplier_id = p.supplier_id
INNER JOIN categories AS c
ON p.category_id = c.category_id
WHERE s.region IS NOT NULL
ORDER BY 
	supplier_region,
	c.category_name,
	p.unit_price;
	
--Result:
+──────────────────+────────────────────+───────────────────+───────────────────+──────────────────+
| "category_name"  | "supplier_region"  | "units_in_stock"  | "units_on_order"  | "reorder_level"  |
+──────────────────+────────────────────+───────────────────+───────────────────+──────────────────+
| "Condiments"     | "America"          | 113               | 0                 | 25               |
| "Confections"    | "America"          | 17                | 0                 | 0                |
| "Meat/Poultry"   | "America"          | 21                | 0                 | 10               |
| "Meat/Poultry"   | "America"          | 115               | 0                 | 20               |
| "Beverages"      | "Asia-Pacific"     | 15                | 10                | 30               |
| "Condiments"     | "Asia-Pacific"     | 24                | 0                 | 5                |
| "Confections"    | "Asia-Pacific"     | 29                | 0                 | 10               |
| "Grains/Cereals" | "Asia-Pacific"     | 38                | 0                 | 25               |
| "Meat/Poultry"   | "Asia-Pacific"     | 0                 | 0                 | 0                |
| "Meat/Poultry"   | "Asia-Pacific"     | 0                 | 0                 | 0                |
| "Produce"        | "Asia-Pacific"     | 20                | 0                 | 10               |
| "Seafood"        | "Asia-Pacific"     | 42                | 0                 | 0                |
| "Beverages"      | "Europe"           | 52                | 0                 | 10               |
| "Beverages"      | "Europe"           | 111               | 0                 | 15               |
| "Beverages"      | "Europe"           | 20                | 0                 | 15               |
| "Condiments"     | "Europe"           | 4                 | 100               | 20               |
| "Condiments"     | "Europe"           | 76                | 0                 | 0                |
| "Condiments"     | "Europe"           | 0                 | 0                 | 0                |
| "Condiments"     | "Europe"           | 53                | 0                 | 0                |
| "Condiments"     | "Europe"           | 120               | 0                 | 25               |
| "Condiments"     | "Europe"           | 6                 | 0                 | 0                |
| "Dairy Products" | "Europe"           | 22                | 30                | 30               |
| "Dairy Products" | "Europe"           | 86                | 0                 | 0                |
| "Produce"        | "Europe"           | 15                | 0                 | 10               |
| "Seafood"        | "Europe"           | 85                | 0                 | 10               |
| "Seafood"        | "Europe"           | 123               | 0                 | 30               |
+──────────────────+────────────────────+───────────────────+───────────────────+──────────────────+