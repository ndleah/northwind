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
	s.region AS supplier_region,
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
	s.region,
	c.category_name,
	p.unit_price;

--Result
+──────────────────+────────────────────+───────────────────+───────────────────+──────────────────+
| "category_name"  | "supplier_region"  | "units_in_stock"  | "units_on_order"  | "reorder_level"  |
+──────────────────+────────────────────+───────────────────+───────────────────+──────────────────+
| "Dairy Products" | "Asturias"         | 22                | 30                | 30               |
| "Dairy Products" | "Asturias"         | 86                | 0                 | 0                |
| "Condiments"     | "LA"               | 4                 | 100               | 20               |
| "Condiments"     | "LA"               | 76                | 0                 | 0                |
| "Condiments"     | "LA"               | 0                 | 0                 | 0                |
| "Condiments"     | "LA"               | 53                | 0                 | 0                |
| "Seafood"        | "MA"               | 85                | 0                 | 10               |
| "Seafood"        | "MA"               | 123               | 0                 | 30               |
| "Condiments"     | "MI"               | 120               | 0                 | 25               |
| "Condiments"     | "MI"               | 6                 | 0                 | 0                |
| "Produce"        | "MI"               | 15                | 0                 | 10               |
| "Grains/Cereals" | "NSW"              | 38                | 0                 | 25               |
| "Meat/Poultry"   | "NSW"              | 0                 | 0                 | 0                |
| "Produce"        | "NSW"              | 20                | 0                 | 10               |
| "Beverages"      | "OR"               | 111               | 0                 | 15               |
| "Beverages"      | "OR"               | 52                | 0                 | 10               |
| "Beverages"      | "OR"               | 20                | 0                 | 15               |
| "Condiments"     | "Québec"           | 113               | 0                 | 25               |
| "Confections"    | "Québec"           | 17                | 0                 | 0                |
| "Meat/Poultry"   | "Québec"           | 21                | 0                 | 10               |
| "Meat/Poultry"   | "Québec"           | 115               | 0                 | 20               |
| "Beverages"      | "Victoria"         | 15                | 10                | 30               |
| "Condiments"     | "Victoria"         | 24                | 0                 | 5                |
| "Confections"    | "Victoria"         | 29                | 0                 | 10               |
| "Meat/Poultry"   | "Victoria"         | 0                 | 0                 | 0                |
| "Seafood"        | "Victoria"         | 42                | 0                 | 0                |
+──────────────────+────────────────────+───────────────────+───────────────────+──────────────────+
