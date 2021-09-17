/********************************
-- Question 8
The Pricing Team wants to know for each currently offered product how their unit price
compares against their categories average and median unit price. In order to help them 
they asked you to provide them a list of products with:
1. their category name
2. their product name
3. their unit price
4. their category average unit price (formatted to have only 2 decimals)
5. their category median unit price (formatted to have only 2 decimals)
6. their position against the category average unit price as:
    * “Below Average”
    * “Equal Average”
    * “Over Average”
7. their position against the category median unit price as:
    * “Below Median”
    * “Equal Median”
    * “Over Median”

Filtered on the following conditions:
    * They are not discontinued

*Finally order the results by category name then product name (both ascending).
***********************************/

--Solution query
WITH cte_price AS (
	SELECT 
		c.category_name,
		p.product_name,
		p.unit_price,
		ROUND(AVG(o.unit_price)::NUMERIC,2) AS average_unit_price,
		ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY o.unit_price))::NUMERIC,2) AS median_unit_price
	FROM categories AS c
	INNER JOIN products AS p
	ON c.category_id = p.category_id
	INNER JOIN order_details AS o
	ON p.product_id = o.product_id
	WHERE p.discontinued = 0
	GROUP BY 
		c.category_name,
		p.product_name,
		p.unit_price
)
SELECT
	category_name,
	product_name,
	unit_price,
	average_unit_price,
	median_unit_price,
	CASE
		WHEN unit_price > average_unit_price THEN 'Over Average'
		WHEN unit_price = average_unit_price THEN 'Equal Average'
		WHEN unit_price < average_unit_price THEN 'Below Average'
	END AS average_unit_price_position,
	CASE
		WHEN unit_price > median_unit_price THEN 'Over Average'
		WHEN unit_price = median_unit_price THEN 'Equal Average'
		WHEN unit_price < median_unit_price THEN 'Below Average'
	END AS median_unit_price_position
FROM cte_price
ORDER BY 
	category_name,
	product_name;


--Result
+──────────────────+─────────────────────────────────────+───────────────+───────────────────────+──────────────────────+────────────────────────────────+───────────────────────────────+
| "category_name"  | "product_name"                      | "unit_price"  | "average_unit_price"  | "median_unit_price"  | "average_unit_price_position"  | "median_unit_price_position"  |
+──────────────────+─────────────────────────────────────+───────────────+───────────────────────+──────────────────────+────────────────────────────────+───────────────────────────────+
| "Beverages"      | "Côte de Blaye"                     | 263.5         | 245.93                | 263.50               | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Chartreuse verte"                  | 18            | 16.68                 | 18.00                | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Ipoh Coffee"                       | 46            | 43.04                 | 46.00                | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Lakkalikööri"                      | 18            | 16.98                 | 18.00                | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Laughing Lumberjack Lager"         | 14            | 13.72                 | 14.00                | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Outback Lager"                     | 15            | 14.15                 | 15.00                | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Rhönbräu Klosterbier"              | 7.75          | 7.38                  | 7.75                 | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Sasquatch Ale"                     | 14            | 12.97                 | 14.00                | "Over Average"                 | "Equal Average"               |
| "Beverages"      | "Steeleye Stout"                    | 18            | 17.00                 | 18.00                | "Over Average"                 | "Equal Average"               |
| "Condiments"     | "Aniseed Syrup"                     | 10            | 9.50                  | 10.00                | "Over Average"                 | "Equal Average"               |
| "Condiments"     | "Chef Anton's Cajun Seasoning"      | 22            | 20.68                 | 22.00                | "Over Average"                 | "Equal Average"               |
| "Condiments"     | "Genen Shouyu"                      | 13            | 14.47                 | 15.50                | "Below Average"                | "Below Average"               |
| "Condiments"     | "Grandma's Boysenberry Spread"      | 25            | 24.17                 | 25.00                | "Over Average"                 | "Equal Average"               |
| "Condiments"     | "Gula Malacca"                      | 19.45         | 18.13                 | 19.45                | "Over Average"                 | "Over Average"                |
| "Condiments"     | "Louisiana Fiery Hot Pepper Sauce"  | 21.05         | 19.46                 | 21.05                | "Over Average"                 | "Below Average"               |
| "Condiments"     | "Louisiana Hot Spiced Okra"         | 17            | 15.30                 | 15.30                | "Over Average"                 | "Over Average"                |
| "Condiments"     | "Northwoods Cranberry Sauce"        | 40            | 38.77                 | 40.00                | "Over Average"                 | "Equal Average"               |
| "Condiments"     | "Original Frankfurter grüne Soße"   | 13            | 12.11                 | 13.00                | "Over Average"                 | "Equal Average"               |
| "Condiments"     | "Sirop d'érable"                    | 28.5          | 27.79                 | 28.50                | "Over Average"                 | "Equal Average"               |
| "Condiments"     | "Vegie-spread"                      | 43.9          | 40.79                 | 43.90                | "Over Average"                 | "Over Average"                |
| "Confections"    | "Chocolade"                         | 12.75         | 11.90                 | 12.75                | "Over Average"                 | "Equal Average"               |
| "Confections"    | "Gumbär Gummibärchen"               | 31.23         | 28.86                 | 31.23                | "Over Average"                 | "Below Average"               |
| "Confections"    | "Maxilaku"                          | 20            | 18.48                 | 20.00                | "Over Average"                 | "Equal Average"               |
| "Confections"    | "NuNuCa Nuß-Nougat-Creme"           | 14            | 13.07                 | 14.00                | "Over Average"                 | "Equal Average"               |
| "Confections"    | "Pavlova"                           | 17.45         | 16.38                 | 17.45                | "Over Average"                 | "Over Average"                |
| "Confections"    | "Scottish Longbreads"               | 12.5          | 11.54                 | 12.50                | "Over Average"                 | "Equal Average"               |
| "Confections"    | "Schoggi Schokolade"                | 43.9          | 40.97                 | 43.90                | "Over Average"                 | "Over Average"                |
| "Confections"    | "Sir Rodney's Marmalade"            | 81            | 75.94                 | 81.00                | "Over Average"                 | "Equal Average"               |
| "Confections"    | "Sir Rodney's Scones"               | 10            | 9.38                  | 10.00                | "Over Average"                 | "Equal Average"               |
| "Confections"    | "Tarte au sucre"                    | 49.3          | 46.41                 | 49.30                | "Over Average"                 | "Below Average"               |
| "Confections"    | "Teatime Chocolate Biscuits"        | 9.2           | 8.53                  | 9.20                 | "Over Average"                 | "Below Average"               |
| "Confections"    | "Valkoinen suklaa"                  | 16.25         | 14.95                 | 16.25                | "Over Average"                 | "Equal Average"               |
| "Confections"    | "Zaanse koeken"                     | 9.5           | 9.14                  | 9.50                 | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Camembert Pierrot"                 | 34            | 32.13                 | 34.00                | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Flotemysost"                       | 21.5          | 19.76                 | 21.50                | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Geitost"                           | 2.5           | 2.33                  | 2.50                 | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Gorgonzola Telino"                 | 12.5          | 11.67                 | 12.50                | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Gudbrandsdalsost"                  | 36            | 33.45                 | 36.00                | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Mascarpone Fabioli"                | 32            | 30.72                 | 32.00                | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Mozzarella di Giovanni"            | 34.8          | 32.04                 | 34.80                | "Over Average"                 | "Below Average"               |
| "Dairy Products" | "Queso Cabrales"                    | 21            | 19.60                 | 21.00                | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Queso Manchego La Pastora"         | 38            | 36.91                 | 38.00                | "Over Average"                 | "Equal Average"               |
| "Dairy Products" | "Raclette Courdavault"              | 55            | 51.13                 | 55.00                | "Over Average"                 | "Equal Average"               |
| "Grains/Cereals" | "Filo Mix"                          | 7             | 6.76                  | 7.00                 | "Over Average"                 | "Equal Average"               |
| "Grains/Cereals" | "Gnocchi di nonna Alice"            | 38            | 35.42                 | 38.00                | "Over Average"                 | "Equal Average"               |
| "Grains/Cereals" | "Gustaf's Knäckebröd"               | 21            | 20.40                 | 21.00                | "Over Average"                 | "Equal Average"               |
| "Grains/Cereals" | "Ravioli Angelo"                    | 19.5          | 18.14                 | 19.50                | "Over Average"                 | "Equal Average"               |
| "Grains/Cereals" | "Tunnbröd"                          | 9             | 8.37                  | 9.00                 | "Over Average"                 | "Equal Average"               |
| "Grains/Cereals" | "Wimmers gute Semmelknödel"         | 33.25         | 31.03                 | 33.25                | "Over Average"                 | "Equal Average"               |
| "Meat/Poultry"   | "Pâté chinois"                      | 24            | 22.40                 | 24.00                | "Over Average"                 | "Equal Average"               |
| "Meat/Poultry"   | "Tourtière"                         | 7.45          | 6.80                  | 7.45                 | "Over Average"                 | "Below Average"               |
| "Produce"        | "Longlife Tofu"                     | 10            | 8.77                  | 8.00                 | "Over Average"                 | "Over Average"                |
| "Produce"        | "Manjimup Dried Apples"             | 53            | 50.55                 | 53.00                | "Over Average"                 | "Equal Average"               |
| "Produce"        | "Tofu"                              | 23.25         | 21.35                 | 23.25                | "Over Average"                 | "Equal Average"               |
| "Produce"        | "Uncle Bob's Organic Dried Pears"   | 30            | 29.17                 | 30.00                | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Boston Crab Meat"                  | 18.4          | 17.23                 | 18.40                | "Over Average"                 | "Below Average"               |
| "Seafood"        | "Carnarvon Tigers"                  | 62.5          | 59.72                 | 62.50                | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Escargots de Bourgogne"            | 13.25         | 12.66                 | 13.25                | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Gravad lax"                        | 26            | 23.40                 | 23.40                | "Over Average"                 | "Over Average"                |
| "Seafood"        | "Ikura"                             | 31            | 29.68                 | 31.00                | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Inlagd Sill"                       | 19            | 17.90                 | 19.00                | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Jack's New England Clam Chowder"   | 9.65          | 9.19                  | 9.65                 | "Over Average"                 | "Below Average"               |
| "Seafood"        | "Konbu"                             | 6             | 5.76                  | 6.00                 | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Nord-Ost Matjeshering"             | 25.89         | 24.27                 | 25.89                | "Over Average"                 | "Below Average"               |
| "Seafood"        | "Röd Kaviar"                        | 15            | 14.36                 | 15.00                | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Rogede sild"                       | 9.5           | 9.23                  | 9.50                 | "Over Average"                 | "Equal Average"               |
| "Seafood"        | "Spegesild"                         | 12            | 11.11                 | 12.00                | "Over Average"                 | "Equal Average"               |
+──────────────────+─────────────────────────────────────+───────────────+───────────────────────+──────────────────────+────────────────────────────────+───────────────────────────────+
