/********************************
-- Question 9
The Sales Team wants to build another list of KPIs to measure employees' performances across each category. 
In order to help them they asked you to provide them a list of categories and employees with:
1. their categories name
2. their full name (first name and last name combined in a 3. single field)
3. their total sales amount including discount (formatted to have only 2 decimals)
4. their percentage of total sales amount against the total sales amount across all employees (formatted to have only 2 decimals)
5. their percentage of total sales amount against the total sales amount for each employees (formatted to have only 2 decimals)

Finally order the results by category name (ascending) then total sales amount (descending).
***********************************/

--Solution query
WITH cte_kpi AS (
SELECT
    c.category_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name,
    ROUND(
		  SUM(d.quantity * d.unit_price)::NUMERIC,
		  2) AS total_sale_amount_including_discount
    
	

--Result
