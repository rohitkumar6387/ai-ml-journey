CREATE DATABASE Library_management;
USE Library_management;

CREATE TABLE Books(
book_id int PRIMARY KEY,
title VARCHAR(100),
author VARCHAR(50),
category VARCHAR(30),
coples_available INT,
price int
);

CREATE TABLE Members(
memeber_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(30),
join_date date
);

CREATE TABLE Issued_books(
issue_id INT PRIMARY KEY,
book_id INT,
member_id INT,
issue_date DATE,
return_date DATE,
FOREIGN KEY (book_id) REFERENCEs Books(book_id),
FOREIGN KEY (member_id) REFERENCEs Members(memeber_id)
);

INSERT INTO Books 
Values
(1,"Winges of fire","A.P.J. Abdul Kalam","Biography",3,299),
(2,"The Alchemist","Paulo coelho","Fiction",2,350),
(3,"Atomic Habits","Jaames Clear","self_Help",5,499),
(4,"Python Basics","John Doe","Education",4,600),
(5,"Ikigal","Hector Garcia","Self-Help",1,250),
(6,"Rich dad Poor dad","Robert Kiyoski","Finance",0,399),
(7,"Deep Work","cal Newport","self_Help",3,450);

INSERT INTO Members
VALUES 
(101,"Rahul","Delhi","2024-01-10"),
(102,"Priya","Mumbai","2024-02-15"),
(103,"Aman","Delhi","2024-03-01"),
(104,"Sneha","Pune","2024-04-20"),
(105,"Vikas","Bangalore","2024-01-25");

INSERT INTO Issued_books
Values
(1,1,101,"2024-05-01","2024-05-10"),
(2,3,101,"2024-05-05",Null),
(3,2,102,"2024-05-02","2024-05-12"),
(4,3,103,"2024-05-08",Null),
(5,4,101,"2024-05-10",Null),
(6,5,104,"2024-04-05","2024-05-05"),
(7,1,105,"2024-05-15",Null),
(8,7,102,"2024-04-10","2024_04-25");

SELECT*FROM Books
WHERE price>400;

SELECT*FROM Books
WHERE coples_available=0;

SELECT*FROM Books
WHERE REPLACE(LOWER(category),'_','-') = LOWER('self-Help');

SELECT category,sum(coples_available)
FROM Books
GROUP BY category;

SELECT author,title,price
FROM Books
WHERE price=(SELECT MAX(price) FROM Books);

SELECT city,count(memeber_id)
FROM Members
GROUP BY city;

SELECT
m.name as member_name,
b.title as book_title,
ib.issue_date
FROM issued_books ib
JOIN Members m On ib.member_id=m.memeber_id
JOIN Books b on ib.book_id=b.book_id
ORDER BY m.name;

SELECT
b.title as book_title,
ib.issue_date,
ib.return_date
FROM issued_books ib
join Books b on ib.book_id=b.book_id
WHERE return_date is null;

SELECT
m.name,
sum(b.price) as book_price
FROM issued_books ib
JOIN Members m On ib.member_id=m.memeber_id
JOIN Books b on ib.book_id=b.book_id
where m.name='Rahul'
GROUP BY m.name
ORDER BY m.name;

SELECT
b.title as book_title,
ib.issue_date
FROM issued_books ib
JOIN Books b on ib.book_id=b.book_id
WHERE ib.issue_date>='2024-05-03' AND ib.issue_date<='2024-05-18'
ORDER BY ib.issue_date DESC;

SELECT
b.title as book_title,
ib.issue_date,
ib.return_date
FROM issued_books ib 
JOIN Books b on ib.book_id=b.book_id
WHERE ib.return_date-ib.issue_date>=11
ORDER BY ib.issue_date;

SELECT
member_id,count(member_id)
FROM issued_books
GROUP BY member_id;

SELECT
b.book_id,b.title
FROM Books b
LEFT JOIN issued_books ib on b.book_id=ib.book_id
WHERE ib.book_id is null;

SELECT
b.book_id,b.title,count(ib.book_id)
FROM Books b
join issued_books ib on b.book_id=ib.book_id
group by b.book_id
ORDER BY COUNT(ib.book_id) DESC
LIMIT 1;

SELECT
member_id,count(member_id)
FROM issued_books
GROUP BY member_id
ORDER BY count(member_id) DESC
LIMIT 1;