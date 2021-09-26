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