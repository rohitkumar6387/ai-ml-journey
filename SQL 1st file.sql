CREATE DATABASE IF NOT EXISTS instagram;
USE instagram;
CREATE TABLE user(
id INT PRIMARY KEY,
age INT,
name VARCHAR(30) NOT NULL,
email VARCHAR(50) UNIQUE,
followers INT DEFAULT 0,
following INT,
CONSTRAINT age CHECK (age>13)
);
INSERT INTO user
values
(101,14,"adam","adam@gmail.com",213,15),
(102,15,"bob","bob@gmail.com",134,124),
(103,16,"chill","chi@gmail.com",176,324);

SELECT*FROM user
LIMIT 2;
SELECT*FROM user
order by followers DESC;
SELECT age,name,followers from user
where age between 15 and 17;
SELECT sum(followers) from user;
INSERT INTO user
(id,age,name,email,followers,following)
values
(104,14,"eve","eve@gmail.com",432,234),
(105,16,"farah","farah@gmail.com",324,123);
SELECT age,count(id)
FROM user
GROUP BY age
HAVING age%2=0;
UPDATE user
SET followers=134
WHERE age=15;
SET SQL_SAFE_UPDATES=0;
ALTER TABLE user
ADD COLUMN city VARCHAR(30) DEFAULT "delhi";

ALTER TABLE user
DROP COLUMN city;

ALTER TABLE user
RENAME TO instauser;

ALTER TABLE instauser
RENAME TO user;

ALTER TABLE user
CHANGE COLUMN followers subs int;
ALTER TABLE user
CHANGE COLUMN subs followers int;

ALTER TABLE user
MODIFY followers int DEFAULT 100;
SELECT*FROM user;



SELECT*FROM user;
CREATE TABLE post(
id int primary key,
content varchar(100),
user_id int,
foreign key(user_id) references user(id)
);
INSERT INTO post
values
(1,"Hello",101),
(2,"byy",103);

SELECT*FROM post;