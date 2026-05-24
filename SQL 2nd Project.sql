CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Users(
user_id INT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(50),
city VARCHAR(30)
);

INSERT INTO Users
VALUES
(1,'Rahul Singh','rahul@gamil.com','Delhi'),
(2,'Priya Mehta','priya@gmail.com',"Mumbai"),
(3,'Aman Khan','aman@gmail.com','Delhi'),
(4,'Sneha Reddy','sneha@gmail.com','Bangalore'),
(5,'Vikas Joshi','vikas@gmail.com','Pune');

CREATE TABLE Products(
product_id INT PRIMARY KEY,
name VARCHAR(30),
category VARCHAR(30),
price DECIMAL(10,2),
stock int
);

INSERT INTO Products
VALUES
(101,'iphone 15','Mobile',79999.00,15),
(102,'Samsung TV 55','Electronics',54999.00,8),
(103,'Nike shoes','Fashion',7999.00,25),
(104,'HP Laptop','Laptop',65999.00,5),
(105,'Boat Headphone','Electronics',1999.00,50),
(106,'Adidas T-shirt','Fashion',1299,0);

CREATE TABLE Orders(
order_id INT PRIMARY KEY,
user_id INT,
order_date DATE,
total_amount DECIMAL(10,2),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Orders
VALUES
(1001,1,'2026-05-01',81998.00),
(1002,2,'2026-05-03',54999.00),
(1003,1,'2026-05-10',65999.00),
(1004,3,'2026-05-12',1999.00),
(1005,4,'2026-05-15',9298.00),
(1006,1,'2026-05-18',7999.00);

CREATE TABLE Order_Details(
detail_id INT,
order_id int,
product_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Order_Details
VALUES
(1,1001,101,1),
(2,1001,105,1),
(3,1002,102,1),
(4,1003,104,1),
(5,1004,105,1),
(6,1005,103,1),
(7,1005,105,1),
(8,1006,103,1);

SELECT*FROM Products;

SELECT*FROM Users
WHERE city='Delhi';

SELECT*FROM Products
WHERE stock=0;

SELECT*FROM Products
WHERE price>10000;

SELECT*FROM Orders
WHERE order_date>'2026-05-10';

SELECT*FROM Orders
ORDER BY total_amount DESC
limit 3;

SELECT 
u.name,p.name as product_name,p.price
from Users u
JOIN Orders o ON u.user_id=o.user_id
JOIN Order_Details od ON o.order_id =od.order_id
JOIN Products p ON od.product_id=p.product_id
WHERE u.name='Rahul Singh';

SELECT
u.name,o.order_id,o.total_amount
FROM Users u
JOIN Orders o ON u.user_id=o.user_id;

SELECT 
u.name
FROM Users u 
JOIN Orders o ON u.user_id=o.user_id
JOIN Order_Details od on o.order_id=od.order_id
JOIN Products p ON od.product_id=p.product_id
WHERE p.name='iphone 15';

SELECT user_id,sum(total_amount)
FROM Orders
GROUP BY user_id;

SELECT product_id,sum(quantity)
FROM Order_Details
GROUP BY product_id;

SELECT category,count(product_id)
FROM Products
GROUP BY category;

SELECT p.category,
     SUM(od.quantity) AS total_quantity_sold,
     SUM(od.quantity*p.price) AS total_sale_amount
FROM Products p 
JOIN Order_Details od ON p.product_id=od.product_id 
GROUP BY p.category 
ORDER BY total_quantity_sold DESC;

SELECT 
p.name,p.product_id
FROM Products p
LEFT JOIN Order_Details od ON p.product_id=od.product_id
WHERE od.product_id is null;

SELECT 
product_id,sum(quantity) AS total_quantity_sale
FROM Order_Details 
GROUP BY product_id
ORDER BY total_quantity_sale DESC
LIMIT 1;

SELECT 
u.name,o.user_id,sum(o.total_amount) AS Total_expense
FROM Orders o 
JOIN Users u ON o.user_id=u.user_id
GROUP BY o.user_id
HAVING Total_expense>50000;

SELECT 
sum(total_amount) AS Total_sale_in_last_15_Days
FROM Orders
Where order_date<='2026-05-18' and order_date>'2026-05-03';

SELECT 
order_id,total_amount AS Total_amount
FROM Orders
WHERE Total_amount>=(SELECT AVG(total_amount) FROM Orders);