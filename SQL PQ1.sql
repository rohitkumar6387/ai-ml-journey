CREATE DATABASE Ecommerce;
USE Ecommerce;
CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_name VARCHAR(50),
product VARCHAR(50),
category VARCHAR(50),
price INT,
order_date date
);

INSERT INTO orders
VALUES
(1,'Amit','iPhone 15','Electronics',80000,'2026-04-01'),
(2,'Priya','T-shirt','Fashion','800','2026-04-02'),
(3,'Rohan','Laptop','Electronics',55000,'2026-04-02'),
(4,'Amit','Jeans','Fashion',2000,'2026-04-03'),
(5,'Sneha','iPhone 15','Electronics',80000,'2026-04-04'),
(6,'Vikas','Shoes','Fashion',3000,'2026-04-05'),
(7,'Priya','Laptop','Electronics',55000,'2026-04-05');

SELECT*FROM orders;

SELECT SUM(price)
From orders;

SELECT category,sum(price)
FROM orders
GROUP BY category;

SELECT customer_name,sum(price)
FROM orders 
GROUP BY customer_name
ORDER BY sum(price) DESC
LIMIT 1;