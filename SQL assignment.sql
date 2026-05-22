CREATE DATABASE company;
USE company;
CREATE TABLE employee(
EmplD int PRIMARY KEY,
Firstname VARCHAR(30),
Lastname VARCHAR(30),
Department VARCHAR(20),
Salary int,
HireDate Date
);

INSERT INTO employee
values
(101,"Alice","johnson","IT",6500,'2020-03-15'),
(102,"Mark","Rivera","HR",4800,'2019-07-22'),
(103,"Sophia","Lee","Finance",7200,'2021-01-10'),
(104,"Daniel","Kim","IT",5800,'2018-11-05'),
(105,"Emma","Brown","Marketing",5300,'2022-04-18'),
(106,"Liam","Patel","Finance",6900,'2020-09-29'),
(107,"Olivia","Garcia","HR",4600,'2017-06-30'),
(108,"Noah","Thompson","IT",7500,'2023-02-12'),
(109,"Ava","Martinez","Marketing",5100,'2019-12-02'),
(110,"Ethan","Davis","Finance",8000,'2016-05-14');
SELECT*FROM employee;
SELECT Firstname,Lastname,Salary FROM employee;
SELECT*FROM employee
WHERE Department="IT";

SELECT*FROM employee
WHERE Salary>6000;

SELECT*FROM employee
ORDER BY HireDate DESC;

SELECT DISTINCT Department FROM employee;

SELECT *FROM employee
WHERE Firstname in ('A');

SELECT*FROM employee
WHERE Firstname LIKE 'A%';
SELECT*FROM employee
WHERE Salary BETWEEN 4000 AND 7000;

SELECT avg(Salary)
FROM employee;

SELECT Department,count(EmplD)
FROM employee
GROUP BY Department
HAVING count(EmplD)>=3;