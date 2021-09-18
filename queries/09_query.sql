/********************************
-- Question 9
The Sales Team wants to build a list of KPIs to measure employees' performances. 
In order to help them they asked you to provide them a list of employees with:

1. their full name (first name and last name combined in a single field)
2. their job title
3. their total sales amount excluding discount (formatted to have only 2 decimals)
4. their total number of orders
5. their total number of entries (each row of an order)
6. their average amount per entry (formatted to have only 2 decimals)
7. their average amount per order (formatted to have only 2 decimals)
8. their total discount amount (formatted to have only 2 decimals)
9. their total sales amount including discount (formatted to have only 2 decimals)
10. Their total discount percentage (formatted to have only 2 decimals)

Finally order the results by total sales amount including discount (descending).
***********************************/

--Solution query
WITH cte_kpi AS (
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name,
	e.title AS employee_title,
	ROUND(
		SUM(d.quantity * d.unit_price)::NUMERIC,
		2) AS total_sale_amount_excluding_discount,
    COUNT(DISTINCT d.order_id) AS total_number_orders,
    COUNT(d.*) AS total_number_entries,
		ROUND(
		SUM(d.discount*(d.quantity * d.unit_price))::NUMERIC,
		2) AS total_discount_amount,
	ROUND(
		SUM((1 - d.discount)*(d.quantity * d.unit_price))::NUMERIC,
		2) AS total_sale_amount_including_discount
FROM orders AS o
INNER JOIN employees AS e
ON o.employee_id = e.employee_id
INNER JOIN order_details AS d
ON d.order_id = o.order_id
INNER JOIN products AS p
ON d.product_id = p.product_id
GROUP BY 
	employee_full_name,
	employee_title
)
SELECT 
	employee_full_name,
	employee_title,
	total_sale_amount_excluding_discount,
	total_number_orders,
	total_number_entries,
	ROUND(
		SUM(total_sale_amount_excluding_discount/total_number_entries),
		   2) AS average_amount_per_entry,
	ROUND(
		SUM(total_sale_amount_excluding_discount/total_number_orders),
		   2) AS average_amount_per_order,
	total_discount_amount,
	total_sale_amount_including_discount,
	SUM(ROUND(
		(total_sale_amount_excluding_discount-total_sale_amount_including_discount)/total_sale_amount_excluding_discount*100,
		2)) AS total_discount_percentage
FROM cte_kpi
GROUP BY
	employee_full_name,
	employee_title,
	total_sale_amount_excluding_discount,
	total_number_orders,
	total_number_entries,
	total_sale_amount_including_discount,
	total_discount_amount
ORDER BY total_sale_amount_including_discount DESC;

--Result
+───────────────────────+─────────────────────────────+─────────────────────────────────────────+────────────────────────+─────────────────────────+─────────────────────────────+─────────────────────────────+──────────────────────────+─────────────────────────────────────────+──────────────────────────────+
| "employee_full_name"  | "employee_title"            | "total_sale_amount_excluding_discount"  | "total_number_orders"  | "total_number_entries"  | "average_amount_per_entry"  | "average_amount_per_order"  | "total_discount_amount"  | "total_sale_amount_including_discount"  | "total_discount_percentage"  |
+───────────────────────+─────────────────────────────+─────────────────────────────────────────+────────────────────────+─────────────────────────+─────────────────────────────+─────────────────────────────+──────────────────────────+─────────────────────────────────────────+──────────────────────────────+
| "Margaret Peacock"    | "Sales Representative"      | 250187.45                               | 156                    | 420                     | 595.68                      | 1603.77                     | 17296.60                 | 232890.85                               | 6.91                         |
| "Janet Leverling"     | "Sales Representative"      | 213051.30                               | 127                    | 321                     | 663.71                      | 1677.57                     | 10238.46                 | 202812.84                               | 4.81                         |
| "Nancy Davolio"       | "Sales Representative"      | 202143.71                               | 123                    | 345                     | 585.92                      | 1643.44                     | 10036.11                 | 192107.60                               | 4.96                         |
| "Andrew Fuller"       | "Vice President, Sales"     | 177749.26                               | 96                     | 241                     | 737.55                      | 1851.55                     | 11211.51                 | 166537.76                               | 6.31                         |
| "Laura Callahan"      | "Inside Sales Coordinator"  | 133301.03                               | 104                    | 260                     | 512.70                      | 1281.74                     | 6438.75                  | 126862.28                               | 4.83                         |
| "Robert King"         | "Sales Representative"      | 141295.99                               | 72                     | 176                     | 802.82                      | 1962.44                     | 16727.76                 | 124568.23                               | 11.84                        |
| "Anne Dodsworth"      | "Sales Representative"      | 82964.00                                | 43                     | 107                     | 775.36                      | 1929.40                     | 5655.93                  | 77308.07                                | 6.82                         |
| "Michael Suyama"      | "Sales Representative"      | 78198.10                                | 67                     | 168                     | 465.46                      | 1167.14                     | 4284.97                  | 73913.13                                | 5.48                         |
| "Steven Buchanan"     | "Sales Manager"             | 75567.75                                | 42                     | 117                     | 645.88                      | 1799.23                     | 6775.47                  | 68792.28                                | 8.97                         |
+───────────────────────+─────────────────────────────+─────────────────────────────────────────+────────────────────────+─────────────────────────+─────────────────────────────+─────────────────────────────+──────────────────────────+─────────────────────────────────────────+──────────────────────────────+
