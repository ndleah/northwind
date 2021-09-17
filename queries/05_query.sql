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
SELECT * FROM orders
SELECT * FROM products
SELECT * FROM order_details

-- Solution Query
WITH cte_price AS (
SELECT
	p.product_name,
	p.unit_price AS current_unit_price,
	d.unit_price AS previous_unit_price,
	(p.unit_price - d.unit_price)/d.unit_price*100 AS increase_percentage,
	COUNT(*) AS total_number_orders
FROM products AS p
INNER JOIN order_details AS d
ON p.product_id = d.product_id
GROUP BY 
	p.product_name,
	p.unit_price,
	d.unit_price
)
SELECT * FROM cte_price
WHERE
	increase_percentage NOT BETWEEN 20 AND 30
	AND total_number_orders > 10
ORDER BY increase_percentage;

--Result
+─────────────────────────────────────+───────────────────────+────────────────────────+────────────────────────+────────────────────────+
| "product_name"                      | "current_unit_price"  | "previous_unit_price"  | "increase_percentage"  | "total_number_orders"  |
+─────────────────────────────────────+───────────────────────+────────────────────────+────────────────────────+────────────────────────+
| "Sasquatch Ale"                     | 14                    | 14                     | 0                      | 12                     |
| "Vegie-spread"                      | 43.9                  | 43.9                   | 0                      | 11                     |
| "Steeleye Stout"                    | 18                    | 18                     | 0                      | 26                     |
| "Louisiana Fiery Hot Pepper Sauce"  | 21.05                 | 21.05                  | 0                      | 20                     |
| "Guaraná Fantástica"                | 4.5                   | 4.5                    | 0                      | 36                     |
| "Queso Manchego La Pastora"         | 38                    | 38                     | 0                      | 12                     |
| "Nord-Ost Matjeshering"             | 25.89                 | 25.89                  | 0                      | 22                     |
| "Côte de Blaye"                     | 263.5                 | 263.5                  | 0                      | 16                     |
| "Gula Malacca"                      | 19.45                 | 19.45                  | 0                      | 16                     |
| "Tourtière"                         | 7.45                  | 7.45                   | 0                      | 21                     |
| "Maxilaku"                          | 20                    | 20                     | 0                      | 13                     |
| "Boston Crab Meat"                  | 18.4                  | 18.4                   | 0                      | 28                     |
| "Zaanse koeken"                     | 9.5                   | 9.5                    | 0                      | 17                     |
| "Ipoh Coffee"                       | 46                    | 46                     | 0                      | 19                     |
| "Mozzarella di Giovanni"            | 34.8                  | 34.8                   | 0                      | 23                     |
| "Jack's New England Clam Chowder"   | 9.65                  | 9.65                   | 0                      | 36                     |
| "Tunnbröd"                          | 9                     | 9                      | 0                      | 13                     |
| "Gorgonzola Telino"                 | 12.5                  | 12.5                   | 0                      | 34                     |
| "Scottish Longbreads"               | 12.5                  | 12.5                   | 0                      | 21                     |
| "Rogede sild"                       | 9.5                   | 9.5                    | 0                      | 12                     |
| "Camembert Pierrot"                 | 34                    | 34                     | 0                      | 37                     |
| "Thüringer Rostbratwurst"           | 123.79                | 123.79                 | 0                      | 22                     |
| "Rhönbräu Klosterbier"              | 7.75                  | 7.75                   | 0                      | 35                     |
| "Chai"                              | 18                    | 18                     | 0                      | 29                     |
| "Ravioli Angelo"                    | 19.5                  | 19.5                   | 0                      | 15                     |
| "Konbu"                             | 6                     | 6                      | 0                      | 32                     |
| "Pavlova"                           | 17.45                 | 17.45                  | 0                      | 30                     |
| "Uncle Bob's Organic Dried Pears"   | 30                    | 30                     | 0                      | 25                     |
| "Queso Cabrales"                    | 21                    | 21                     | 0                      | 26                     |
| "Alice Mutton"                      | 39                    | 39                     | 0                      | 25                     |
| "Rössle Sauerkraut"                 | 45.6                  | 45.6                   | 0                      | 20                     |
| "Gnocchi di nonna Alice"            | 38                    | 38                     | 0                      | 33                     |
| "Gudbrandsdalsost"                  | 36                    | 36                     | 0                      | 20                     |
| "Escargots de Bourgogne"            | 13.25                 | 13.25                  | 0                      | 14                     |
| "Filo Mix"                          | 7                     | 7                      | 0                      | 24                     |
| "Singaporean Hokkien Fried Mee"     | 14                    | 14                     | 0                      | 22                     |
| "Inlagd Sill"                       | 19                    | 19                     | 0                      | 22                     |
| "Gustaf's Knäckebröd"               | 21                    | 21                     | 0                      | 12                     |
| "Röd Kaviar"                        | 15                    | 15                     | 0                      | 11                     |
| "Tarte au sucre"                    | 49.3                  | 49.3                   | 0                      | 34                     |
| "Sir Rodney's Scones"               | 10                    | 10                     | 0                      | 27                     |
| "Carnarvon Tigers"                  | 62.5                  | 62.5                   | 0                      | 21                     |
| "Chartreuse verte"                  | 18                    | 18                     | 0                      | 19                     |
| "Flotemysost"                       | 21.5                  | 21.5                   | 0                      | 25                     |
| "Manjimup Dried Apples"             | 53                    | 53                     | 0                      | 30                     |
| "Northwoods Cranberry Sauce"        | 40                    | 40                     | 0                      | 11                     |
| "Original Frankfurter grüne Soße"   | 13                    | 13                     | 0                      | 25                     |
| "Outback Lager"                     | 15                    | 15                     | 0                      | 28                     |
| "Spegesild"                         | 12                    | 12                     | 0                      | 17                     |
| "Raclette Courdavault"              | 55                    | 55                     | 0                      | 35                     |
| "Wimmers gute Semmelknödel"         | 33.25                 | 33.25                  | 0                      | 20                     |
| "Chef Anton's Cajun Seasoning"      | 22                    | 22                     | 0                      | 14                     |
| "NuNuCa Nuß-Nougat-Creme"           | 14                    | 14                     | 0                      | 12                     |
| "Pâté chinois"                      | 24                    | 24                     | 0                      | 22                     |
| "Chang"                             | 19                    | 19                     | 0                      | 31                     |
| "Tofu"                              | 23.25                 | 23.25                  | 0                      | 13                     |
| "Sirop d'érable"                    | 28.5                  | 28.5                   | 0                      | 21                     |
| "Ikura"                             | 31                    | 31                     | 0                      | 26                     |
| "Mascarpone Fabioli"                | 32                    | 32                     | 0                      | 12                     |
| "Sir Rodney's Marmalade"            | 81                    | 81                     | 0                      | 11                     |
| "Teatime Chocolate Biscuits"        | 9.2                   | 9.2                    | 0                      | 24                     |
| "Geitost"                           | 2.5                   | 2.5                    | 0                      | 21                     |
| "Perth Pasties"                     | 32.8                  | 32.8                   | 0                      | 18                     |
| "Lakkalikööri"                      | 18                    | 18                     | 0                      | 28                     |
| "Gumbär Gummibärchen"               | 31.23                 | 31.23                  | 0                      | 20                     |
+─────────────────────────────────────+───────────────────────+────────────────────────+────────────────────────+────────────────────────+

