-- 1.	Write a query to display the name, product line, and buy price of all products.  The output columns should display as “Name”, “Product Line”, and “Buy Price”.  The output should display the most expensive items first.
-- display: name, product line, buy price 
-- what: of all products
-- sort most expensive items first

SELECT productname AS "Name", productLine AS "Product Line", buyPrice AS "Buy Price" 
FROM products
ORDER BY buy_price DESC;


-- 2.	Write a query to display the first name, last name, and city for all customers FROM Germany. Columns should display as “First Name”, “Last Name”, and “City”.  The output should be sorted by the customer’s last name (ascending).
--display first name, last name, and city 
-- what of customers FROM germany
-- how sorted by last name in asending order

SELECT customerFirstName AS "Firstname", customerLastName AS "Lastname", city As "City" 
FROM customers 
WHERE country = 'Germany'
ORDER BY last_name;


-- 3.	Write a query to display each of the unique values of the status field in the orders table.  The output should be sorted alphabetically increasing.  Hint: the output should show exactly 6 rows.
--display only distict status 
--what FROM orders
--how sorted alpebetically

SELECT DISTINCT status 
FROM orders 

-- 4.	SELECT all fields FROM the payments table for payments made on or after January 1, 2005.  Output should be sorted by increasing payment date.

--display: all * 

--what: FROM payments table 
--how: <= Date 01-01-2005 sorted by payment date

SELECT * FROM payments
WHERE paymentDate >= '01-01-2005'
ORDER BY paymentDate;

-- 5.	Write a query to display all Last Name, First Name, Email and Job Title of all employees working out of the San Francisco office.  Output should be sorted by last name.
-- display: lastname first name email and job title 
-- FROM/what: join FROM office for employees in San Francisco
-- join empolyees and offices using officeCode

SELECT lastName, firstName, email, jobTitle FROM employees emp 
JOIN offices ofs ON emp.officeCode = ofs.officeCode
WHERE ofs.city = "San Francisco" 
ORDER BY lastName;


-- 6.Write a query to display the Name, Product Line, Scale, and Vendor of all of the car products – both classic and vintage.  The output should display all vintage cars first (sorted alphabetically by name), and all classic cars last (also sorted alphabetically by name).
-- display: name productline scale vendor
-- FROM/what: from products where product line = classic car and vintage car
-- how: sorted by productline desc, then by product name asc
SELECT productName AS "Name", productLine AS "Product Line", productScale AS "Scale", productVendor AS "Vendor" 
FROM products p 
WHERE productLine IN ("Classic Cars", "Vintage Cars") 
ORDER BY productLine DESC, productName ASC; 
