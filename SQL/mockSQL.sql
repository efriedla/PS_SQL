use mocksql


-- 1. Create a query to return all orders made by users with the first name of “Marion”
-- display names who made order that first name is martin
SELECT ORDERS.ORDER_ID AS "ORDER NUMBER", USERS.FIRST_NAME AS "CUSTOMER FIRST NAME"
FROM ORDERS
JOIN USERS ON ORDERS.USER_ID = USERS.USER_ID
WHERE USERS.FIRST_NAME = "Martion";


-- 2. Create a query to select all users that have not made an order

SELECT U.USER_ID, U.FIRST_NAME, U.LAST_NAME, U.CITY
FROM USERS AS U
LEFT JOIN ORDERS AS O
ON U.USERS = O.ORDER_ID
WHERE O.ORDER_ID IS NULL;

-- 3. Create a Query to select the names and prices of all items that have been part of 2 or more separate orders.

SELECT I.NAME, I.PRICE 
FROM ITEMS AS I
JOIN ORDER_ITEMS AS O ON I.ITEM_ID = O.ITEM_ID
GROUP BY I.ITEM_ID
HAVING COUNT(O.ITEM_ID) >= 2;

-- 4. Create a query to return the Order Id, Item name, Item Price, and Quantity from orders made at stores in the city “New York”. Order by Order Id in ascending order.
SELECT O.ORDER_ID, I.NAME, I.PRICE, OI.QUANTITY
FROM STORES AS S
JOIN ORDERS AS O 
ON S.STORE_ID = O.STORE_ID
JOIN ORDER_ITEMS AS OI 
ON O.ORDER_ID = OI.ORDER_ID
JOIN ITEMS AS I 
ON OI.ITEM_ID = I.ITEM_ID
WHERE S.CITY = "New York"
ORDER BY O.ORDER_ID;

-- 5. Your boss would like you to create a query that calculates the total revenue generated by each item. Revenue for an item can be found as (Item Price * Total Quantity Ordered). Please return the first column as ‘ITEM_NAME’ and the second column as ‘REVENUE’.

SELECT I.NAME AS "ITEM_NAME", SUM(I.PRICE * OI.QUANTITY) AS "REVENUE"
FROM ORDER_ITEMS AS OI
JOIN ITEMS AS I 
ON I.ITEM_ID = OI.ITEM_ID
GROUP BY OI.ITEM_ID
ORDER BY REVENUE DESC;


-- 6. Create a query with the following output:
		-- a. Column 1 - Store Name
		-- 	i. The name of each store
		-- b. Column 2 - Order Quantity
 		-- 	i. The number of times an order has been made in this store
		-- c. Column 3 - Sales Figure
		-- 	i. If the store has been involved in more than 3 orders, mark as ‘High’
		-- ii. If the store has been involved in less than 3 orders but more than 1 order, mark as ‘Medium’
		-- iii. If the store has been involved with 1 or less orders, mark as ‘Low’
--		d. Should be ordered by the Order Quantity in Descending Order

SELECT S.NAME, COUNT(O.STORE_ID) AS "Quantity",
CASE 
    WHEN COUNT(O.STORE_ID) > 3 THEN "High"
    WHEN COUNT(O.STORE_ID) <= 3 AND COUNT(O.STORE_ID)> 1 THEN "Medium"
    WHEN COUNT(O.STORE_ID) <= 1 THEN "Low"
    ELSE "Error"
END AS "Sales Figure"
FROM STORES AS S 
JOIN ORDERS AS O
ON S.STORE_ID = O.STORE_ID
GROUP BY 1
ORDER BY 2 DESC;

-- https://replit.com/@efriedla/MockSQL#main.sql