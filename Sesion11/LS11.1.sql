USE Lession11;
CREATE TABLE accounts (
accountID integer primary key,
balance decimal(10,2)
);
INSERT INTO accounts(accountID,balance) VALUES
('1','1000000'),
('2','1100000'),
('3','1200000'),
('4','1300000'),
('5','1400000'),
('6','1500000'),
('7','1600000'),
('8','1700000'),
('9','1800000'),
('10','11200000');
-- kiểm tra số dư trước
SELECT*FROM accounts WHERE accountID = 1;
CREATE TABLE transactions (
transactionID integer primary key,
fromAccountID integer,
FOREIGN KEY (fromAccountID)
REFERENCES accounts(accountID),
toAccountID integer,
FOREIGN KEY (toAccountID)
REFERENCES accounts(accountID),
amount decimal(10,2),
transactionDate datetime
);
SELECT*FROM transactions;
START TRANSACTION;
UPDATE accounts
SET balance=balance + '1000000' 
WHERE accountID = 1;
COMMIT;
-- kiểm tra số dư sau 
SELECT*FROM accounts WHERE accountID = 1;
