CREATE DATABASE prime;
USE prime;
CREATE TABLE accounts(
id int primary key auto_increment,
name varchar(50),
balance decimal(10,2)
);
INSERT INTO accounts(name,balance)
values
("Adam",500.00),
("Bob",700.00),
("Charlie",1000.00);

SELECT *FROM accounts;

START TRANSACTION;
UPDATE accounts SET balance=balance-50 WHERE id=1;
UPDATE accounts SET balance=balance+50 WHERE id=2;
COMMIT;
SELECT *FROM accounts;
DELETE FROM accounts WHERE id>3;
COMMIT;
START TRANSACTION;
UPDATE accounts SET balance=balance-50 WHERE id=1;
UPDATE accounts SET balance=balance+50 WHERE id=2;
ROLLBACK;

START TRANSACTION;
UPDATE accounts SET balance=balance-50 WHERE id=1;
SAVEPOINT after_wallet_topup;
UPDATE accounts SET balance=balance+50 WHERE id=2;
ROLLBACK TO after_wallet_topup;
COMMIT;