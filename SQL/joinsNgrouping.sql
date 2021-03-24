-- 1. Write a query to display each customer’s name (as “Customer Name”) alongside the name of the employee who is responsible for that customer’s orders. The employee name should be in a single “Sales Rep” column formatted as “lastName, firstName”. The output should be sorted alphabetically by customer name.
-- display: customer names, sales rep 
-- from/what: from customers
-- join: customers and employees on employeeNumber == salesRepEmployeeNumber
-- how: sorted by customer name
 
 SELECT cus.customerName AS "Customer Name", CONCAT(emp.firstName, " ", emp.lastName) AS "Sales Rep" 
 FROM customers cus 
 JOIN employees emp 
 ON cus.salesRepEmployeeNumber = emp.employeeNumber ORDER BY 1 ASC;


-- 2. Determine which products are most popular with our customers. For each product, list the total quantity ordered along with the total sale generated (total quantity ordered * priceEach) for that product. The column headers should be “Product Name”, “Total # Ordered” and “Total Sale”. List the products by Total Sale descending.
-- display: product name, total ordered, total sales
-- from/what: products and orderdetails
-- how:
 SELECT prd.productName As "Product Name", SUM(ord.quantityOrdered) As "Total # Ordered", prd.MSRP * SUM(o.quantityOrdered) AS  "Total Sale" 
 FROM products prd JOIN orderdetails ord 
 ON prd.productCode = ord.productCode 
 GROUP BY prd.productCode 
 ORDER BY 3 DESC; 


-- 3. Write a query which lists order status and the # of orders with that status. Column headers should be “Order Status” and “# Orders”. Sort alphabetically by status.
-- display: order status and count number of orders
-- from/what: orders
-- how: grouped by status and sorted order status 
 SELECT ord.status as "Order Status", COUNT(*) as "# Orders" 
 FROM orders ord 
 GROUP BY ord.status 
 ORDER BY ord.status ASC;


-- 4. Write a query to list, for each product line, the total # of products sold from that product line. The first column should be “Product Line” and the second should be “# Sold”. Order by the second column descending.
-- display: product line, # sold
-- from/what: products, -> orderdetails, -> productlines
-- how: grouped by product line
SELECT pl.productLine as "Product Line", SUM(ord.quantityOrdered) as "# Sold" 
FROM products pd 
JOIN orderdetails ord ON pd.productCode = ord.productCode 
JOIN productlines pl ON pl.productLine = pd.productLine 
GROUP BY 1;

-- 5. For each employee who represents customers, output the total # of orders that employee’s customers have placed alongside the total sale amount of those orders. The employee name should be output as a single column named “Sales Rep” formatted as “lastName, firstName”. The second column should be titled “# Orders” and the third should be “Total Sales”. Sort the output by Total Sales descending. Only (and all) employees with the job title ‘Sales Rep’ should be included in the output, and if the employee made no sales the Total Sales should display as “0.00”.
-- display: first & last name as sales rep, # orders, “Total Sales”
-- from/what: employees
-- join customers,orders,orderdetails, 
-- how: group by empoloyee number and order by total sales DESC

SELECT CONCAT(emp.lastName, ", ", emp.firstName) as "Sales Rep", COUNT(DISTINCT ord.orderNumber) AS "# Orders", COALESCE(SUM(odt.priceEach * odt.quantityOrdered), 0) as "Total Sales" 
FROM employees emp 
LEFT JOIN customers cus ON emp.employeeNumber = cus.salesRepEmployeeNumber 
LEFT JOIN orders ord ON ord.customerNumber = cus.customerNumber 
LEFT JOIN orderdetails odt ON ord.orderNumber = odt.orderNumber
WHERE emp.jobTitle = "Sales Rep"
GROUP BY emp.employeeNumber
ORDER BY 3 DESC;

-- 6. Your product team is requesting data to help them create a bar-chart of monthly sales since the company’s inception. Write a query to output the month (January, February, etc.), 4-digit year, and total sales for that month. The first column should be labeled ‘Month’, the second ‘Year’, and the third should be ‘Payments Received’. Values in the third column should be formatted as numbers with two decimals – for example: 694,292.68.
-- display: out push each month, year, total sales = Month, Year, Total Recieved
-- from/what: from payments grouped by months and years payments has 2 decimals
-- how:


SELECT DATE_FORMAT(pay.paymentDate, "%M") AS "Month", DATE_FORMAT(pay.paymentDate, "%Y") AS "Year", FORMAT(SUM(pay.amount), 2) AS "Payments Recieved" 
FROM payments pay
GROUP BY 1, 2 
ORDER BY 2 ASC, 1 ASC;