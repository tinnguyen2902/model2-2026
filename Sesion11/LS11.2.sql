SELECT*FROM accounts;
DELIMITER $$
CREATE PROCEDURE withdraw_money(
IN p_account_id int,
IN p_amount decimal(10,2)
)
BEGIN
  -- khai báo biến lưu số dư khi trừ
   DECLARE v_new_balance DECIMAL(15,2);
   START TRANSACTION;
   -- thực hiện trừ tiền
   UPDATE accounts
   SET balance = balance - p_amount
   WHERE accountID = p_account_id;
   -- lấy số dư
   SELECT balance INTO v_new_balance
   FROM accounts
   WHERE accountID = p_account_id;
   IF v_new_balance < 0 THEN
     ROLLBACK;
     SELECT CONCAT('số dư không đủ. tài khoản còn:', (v_new_balance + p_amount)) AS message;
   ELSE 
	COMMIT;
    SELECT CONCAT (' rút tiền thành công, số tiền mới là:',v_new_balance) AS message;
    END IF;
END $$
DELIMITER ;
CALL withdraw_money('2','500000');
SELECT * FROM accounts WHERE accountID = '2'; -- thành công: số dư còn lại 600k
CALL withdraw_money('2','5000000'); -- trừ 5tr fail do không đủ tiền