CREATE DATABASE store;
USE store;
CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO customers
VALUES
(1,"Bob","Mumbai"),
(2,"Aice","Kanpur"),
(3,"Charlie","Agra"),
(4,"Dave","Pune");

 CREATE TABLE orders(
 order_id INT PRIMARY KEY,
 customer_id INT,
 amount INT 
);

INSERT INTO orders 
VALUES
(101,1,500),
(102,1,900),
(103,2,300),
(104,5,200);

SELECT*FROM customers;
SELECT*FROM orders;
 
SELECT*
FROM customers c
INNER JOIN orders o
ON c.customer_id=o.customer_id;

SELECT*
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT*
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT*
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
UNION
SELECT*
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT *FROM customers
CROSS JOIN orders;

SELECT*FROM customers c 
JOIN customers a 
ON c.customer_id=a.customer_id;

SELECT*
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.customer_id is NULL;

SELECT*
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id
WHERE c.customer_id is NULL;

SELECT*
FROM orders
WHERE amount >(
	SELECT AVG(amount)
    FROM orders
    );
    
SELECT name,(
       SELECT COUNT(*)
       FROM orders o 
       WHERE o.customer_id=c.customer_id
       ) as order_count
	FROM customers c;
    
SELECT
     summary.customer_id,
     summary.avg_amount
FROM
    (
    SELECT 
        customer_id,
        avg(amount) as avg_amount
	FROM orders 
    GROUP BY customer_id
    ) as summary;
    
CREATE VIEW view1 as
SELECT name,customer_id FROM customers;
SELECT*FROM view1;