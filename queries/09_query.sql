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
		SUM(d.quantity * p.unit_price)::NUMERIC,
		2) AS total_sale_amount_excluding_discount,
    COUNT (DISTINCT d.order_id) AS total_number_orders,
    COUNT(d.*) AS total_number_entries,
	ROUND(
		SUM(d.quantity * d.unit_price)::NUMERIC,
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
	AVG(total_number_orders) AS average_amount_per_entry,
	AVG(total_number_entries) AS average_amount_per_order,
	SUM(
		total_sale_amount_excluding_discount - total_sale_amount_including_discount
		) AS total_discount_amount,
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
	total_sale_amount_including_discount
ORDER BY total_sale_amount_including_discount DESC;

--Result
