DELIMITER $$
CREATE PROCEDURE transfer_money (
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_amount DECIMAL(15,2)
)
BEGIN
    DECLARE v_sender_balance DECIMAL(15,2);
    -- bắt lỗi SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Đã xảy ra lỗi hệ thống, giao dịch không thành công' AS status;
    END;
    START TRANSACTION;
    -- lấy số dư người gửi
    SELECT balance
    INTO v_sender_balance
    FROM accounts
    WHERE accountID = p_sender_id
    FOR UPDATE;
    -- kiểm tra đủ tiền hay không
    IF v_sender_balance < p_amount THEN
        ROLLBACK;
        SELECT CONCAT(
            'Số dư không đủ. Số dư hiện tại: ',
            v_sender_balance
        ) AS message;
    ELSE
        -- trừ tiền người gửi
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE accountID = p_sender_id;
        -- cộng tiền người nhận
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE accountID = p_receiver_id;
        -- ghi lịch sử giao dịch
        INSERT INTO transactions1 (account_id, amount, log_message)
        VALUES (
            p_sender_id,
            p_amount,
            CONCAT(
                'Đã chuyển ',
                p_amount,
                ' cho tài khoản ',
                p_receiver_id
            )
        );
        COMMIT;
        SELECT 'Chuyển tiền thành công' AS status;
    END IF;
END $$
DELIMITER ;
-- kiểm thử
SELECT*FROM accounts;
SELECT*FROM transactions1;
CALL transfer_money (4,5,100000);
