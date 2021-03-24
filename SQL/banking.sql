using banking;

-- 1. For each product, show the product name "Product" and the product type name "Type".
-- display: product and type
-- from/what: product and type 
-- how: product_type_cd
SELECT prd.name AS "Product", prd.product_type_cd AS "Type" 
FROM product prd 
JOIN product_type prdt 
ON prd.product_type_cd = prdt.product_type_cd;


-- 2. For each branch, list the branch name and city, plus last name and title of each employee who works in that branch.
-- display: branch name, city, employee last name and title
-- from/what: branch and employee
-- how: connect on assigned_branch_id == branch_id
SELECT brch.name, brch.city, emp.last_name, emp.title 
FROM branch brch
JOIN employee emp 
ON emp.assigned_branch_id = brch.branch_id;


-- 3. Show a list of each unique employee title.
-- display: DISTINCT title
-- showing all of them and grouping by them?
-- from/what: employee
-- how: by title
SELECT emp.title 
FROM employee emp 
GROUP BY emp.title;

-- 4. Show the last name and title of each employee, along with the last name and title of that employee's boss.
-- display: lastname and title, and lastname and title boss
-- from/what: employee
-- how:

SELECT employee.last_name, employee.title, superior.last_name,superior.title
FROM employee 
INNER JOIN employee 
AS superior 
	ON employee.superior_emp_id = superior.emp_id;

-- 5. For each account, show the name of the account's product, the available balance, and the customer's last name.
-- display: product name, avalible balance, last name
-- from/what: account, customer, product, individual
-- how: by cust_id

SELECT prd.name, acc.avail_balance, id.last_name 
FROM account acc 
JOIN customer cuss 
ON acc.cust_id = cuss.cust_id 
JOIN product prd 
ON prd.product_cd = acc.product_cd 
JOIN individual id 
ON id.cust_id = cuss.cust_id;

-- 6. List all account transaction details for individual customers whose last name starts with 'T'.
-- display: last name (start with T) and everything in acc_transaction
-- from/what: individual, customer, account acc_transation
-- how:by account_id that showing only last names that start with T

SELECT id.last_name, acct.* 
FROM individual id 
JOIN customer cuss ON cuss.cust_id = id.cust_id 
JOIN account acc ON acc.cust_id = cuss.cust_id 
JOIN acc_transaction acct ON acct.account_id = acc.account_id 
WHERE id.last_name 
LIKE "T%";
