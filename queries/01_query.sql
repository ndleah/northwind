/********************************
-- Question 1 
For their annual review of the company pricing strategy, the Product Team wants to 
look at the products that are currently being offered for a specific price range ($20 to $50). 

In order to help them they asked you to provide them with a list of products with the following information:
1. their name
2. their unit price

Filtered on the following conditions:

1. their unit price is between 20 and 50
2. they are not discontinued

Finally order the results by unit price in a descending order (highest first).
***********************************/

-- Solution Query
SELECT
	product_name,
	unit_price
FROM products
WHERE unit_price BETWEEN 20 AND 50
AND discontinued = 0
ORDER BY unit_price DESC;

--Result
+────────────────────────────────────+───────────────+
| "product_name"                     | "unit_price"  |
+────────────────────────────────────+───────────────+
| "Tarte au sucre"                   | "49.3"        |
| "Ipoh Coffee"                      | "46"          |
| "Vegie-spread"                     | "43.9"        |
| "Schoggi Schokolade"               | "43.9"        |
| "Northwoods Cranberry Sauce"       | "40"          |
| "Gnocchi di nonna Alice"           | "38"          |
| "Queso Manchego La Pastora"        | "38"          |
| "Gudbrandsdalsost"                 | "36"          |
| "Mozzarella di Giovanni"           | "34.8"        |
| "Camembert Pierrot"                | "34"          |
| "Wimmers gute Semmelknödel"        | "33.25"       |
| "Mascarpone Fabioli"               | "32"          |
| "Gumbär Gummibärchen"              | "31.23"       |
| "Ikura"                            | "31"          |
| "Uncle Bob's Organic Dried Pears"  | "30"          |
| "Sirop d'érable"                   | "28.5"        |
| "Gravad lax"                       | "26"          |
| "Nord-Ost Matjeshering"            | "25.89"       |
| "Grandma's Boysenberry Spread"     | "25"          |
| "Pâté chinois"                     | "24"          |
| "Tofu"                             | "23.25"       |
| "Chef Anton's Cajun Seasoning"     | "22"          |
| "Flotemysost"                      | "21.5"        |
| "Louisiana Fiery Hot Pepper Sauce" | "21.05"       |
| "Queso Cabrales"                   | "21"          |
| "Gustaf's Knäckebröd"              | "21"          |
| "Maxilaku"                         | "20"          |
+────────────────────────────────────+───────────────+