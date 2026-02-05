CREATE TABLE orders (
id int primary key not null,
total DOUBLE not null
);
INSERT INTO orders(id,total)VALUE
('1','12000000'),
('2','1300000'),
('3','14000000');
SELECT*FROM orders;
DELIMITER $$
CREATE PROCEDURE sp_check_orrder_value(IN total_order DOUBLE )
BEGIN
IF total_order < 12000000 THEN
SELECT 'đơn hàng bình thường';
ELSE 
SELECT 'đơn hàng giá trị cao';
END IF;
END $$
DELIMITER ;
CALL sp_check_orrder_value(20000000);