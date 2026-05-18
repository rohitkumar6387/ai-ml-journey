CREATE DATABASE shop;
USE shop;
CREATE TABLE accounts(
account_id INT PRIMARY KEY,
name VARCHAR(50),
balance DECIMAL(10,2),
branch VARCHAR(50)
);
INSERT INTO accounts
VALUES
(1,"Bob",500.00,"Mumbai"),
(2,"Aice",700.00,"Kanpur"),
(3,"Charlie",300.00,"Agra"),
(4,"Dave",1000.00,"Pune");

SELECT*FROM accounts;
CREATE INDEX idx_branch ON accounts(branch);
SHOW INDEX FROM accounts;

DELIMITER $$
CREATE PROCEDURE check_balance (IN acc_id INT)
BEGIN
    SELECT balance
    FROM accounts
    WHERE account_id=acc_id;
END $$
DELIMITER ;

CALL check_balance(2);
DROP procedure IF EXISTS check_balance
DELIMITER $$
CREATE PROCEDURE check_balance (IN acc_id INT, OUT bal DECIMAL(10,2))
BEGIN
    SELECT balance INTO bal
    FROM accounts
    WHERE account_id=acc_id;
END $$
DELIMITER ;

CALL check_balance(1,@balance);
SELECT @balance;