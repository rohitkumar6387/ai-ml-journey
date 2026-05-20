CREATE DATABASE college;
USE college;
CREATE TABLE teacher(
id INT PRIMARY KEY,
name VARCHAR(30),
subject VARCHAR(30),
salary DECIMAL(10,2)
);
INSERT INTO teacher
values
(23,"ajay","math",50000.00),
(47,"bharat","english",60000.00),
(18,"chetan","chemistry",45000.00),
(9,"divya","physics",75000.00);

SELECT*FROM teacher
WHERE salary>55000.00;

ALTER TABLE teacher
CHANGE COLUMN salary ctc int; 

UPDATE teacher
SET ctc=ctc+(0.25)*ctc;
SET SQL_SAFE_UPDATES=0;

SELECT*FROM teacher;
TRUNCATE TABLE teacher;

ALTER TABLE teacher
DROP COLUMN ctc;

ALTER TABLE teacher
ADD COLUMN city VARCHAR(30) DEFAULT 'Gurgaon';