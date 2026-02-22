USE Lession11;
CREATE TABLE transactions1 (
transaction_id int primary key auto_increment,
account_id int,
foreign key (account_id)
references accounts(accountID),
amount decimal(15,2), -- số tiền giao dịch
log_message VARCHAR(255),
transaction_date DATETIME default current_timestamp
);
SELECT*FROM accounts;
DELIMITER $$
CREATE PROCEDURE deposit_with_logging (
IN p_account_id int,
IN p_amount DECIMAL(15,2)
)
BEGIN
  DECLARE v_new_balance DECIMAL(15,2);
  START TRANSACTION;
  -- thực hiện trừ tiền
  UPDATE accounts
  SET balance = balance - p_amount
  WHERE accountID = p_account_id;
  -- check số dư
  SELECT balance INTO v_new_balance
  FROM accounts
  WHERE accountID = p_account_id;
  -- nếu đủ
  IF v_new_balance < 0 THEN
  ROLLBACK;
  SELECT CONCAT('số dư không đủ. tài khoản còn:', (v_new_balance + p_amount)) AS message;
  ELSE
  COMMIT;
  INSERT INTO transactions1 (account_id,amount,log_message) value
  (p_account_id,p_amount,'nạp tiền vào tài khoản');
  END IF;
END $$
DELIMITER ;
CALL deposit_with_logging('2','500000');
SELECT*FROM transactions1;