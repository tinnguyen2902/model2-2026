USE Lession9;
SELECT*FROM customers;
-- tạo stored procedure
DELIMITER $$
CREATE PROCEDURE inset_customer(
IN in_customer_name VARCHAR(50),
IN in_email VARCHAR(10),
IN in_phone VARCHAR(15),
IN in_address VARCHAR(255)
)
BEGIN
INSERT INTO customers(customer_name,email,phone,address)VALUES
(in_customer_name,in_email,in_phone,in_address);
SELECT 'thêm mới khách hàng thành công' AS 'message';
END $$
DELIMITER ;
CALL inset_customer('Nguyen van a','abc@gmai','0909090909','hà nội');