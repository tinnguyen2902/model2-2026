USE Lession12;
CREATE TABLE order_logs (
log_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT NOT NULL,
old_status ENUM('Pending','Completed','Cancelled'),
new_status ENUM('Pending','Completed','Cancelled'),
log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (order_id)
REFERENCES orders(order_id) ON DELETE CASCADE
);
-- tạo trigger check tiền thanh toán với tiền đơn có giống nhau hay k
DELIMITER $$
CREATE TRIGGER before_insert_check_payment
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
   -- gán giá trị đơn
   DECLARE v_order_total DECIMAL(15,2);
   -- lấy số tiền của đơn hàng
   SELECT total_amount INTO v_order_total
   FROM orders
   WHERE order_id = NEW.order_id;
   -- so sánh tiền khách trả (NEW.amount) có khớp k
   IF NEW.amount <> v_order_total THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Lỗi !!! số tiền không khớp';
   END IF;   
END $$
DELIMITER ;
-- check  : hiện ra lỗi số tiền k khớp
INSERT INTO payments (order_id, amount, payment_method, status)
VALUES (1,45000, 'paypal', 'completed');

-- 2.tạo trigger AFTER UPDATE
DELIMITER $$
CREATE TRIGGER after_update_order_status 
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
  IF OLD.status <> NEW.status THEN
  INSERT INTO order_logs (order_id,old_status,new_status) VALUE
  (OLD.order_id,OLD.status,NEW.status);
  END IF;
END $$
DELIMITER ;
-- check 
SELECT*FROM orders;
UPDATE orders 
SET status = 'completed'
WHERE order_id = 3;
SELECT*FROM order_logs; -- có cập nhật ở table order_log

-- 3.Stored Procedure:
DELIMITER $$
CREATE PROCEDURE sp_update_order_status_with_payment (
IN in_order_id int,
IN in_new_status enum('pending','completed','cancelled'),
IN in_payment_amount decimal(10,2),
IN in_payment_method enum('pending','completed','cancelled')
)
BEGIN
  DECLARE v_status enum('pending','completed','cancelled');
  -- khai báo exit nếu có lỗi xảy ra thì rollback
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'lỗi hệ thống';
  END;
  -- bắt đầu giao dịch
  START TRANSACTION;
  -- lấy thông tin đơn hàng
  SELECT status INTO v_status
  FROM orders
  WHERE order_id = in_order_id 
  FOR UPDATE ;
  -- check status đơn có trùng hay không
  IF v_status IS NULL THEN
	ROLLBACK;
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'lỗi!!! đơn hàng không tồn tại';
  END IF;
  -- chuyển sang completed
 IF in_new_status = 'completed' THEN
 -- thêm ở table payments
 INSERT INTO payments(order_id,amount,payment_method,status) value
 (in_order_id,in_payment_amount,in_payment_method,'completed');
 -- cập nhật ở table orders
 UPDATE orders
 SET status = 'completed'
 WHERE order_id = in_order_id;
 -- nếu chuyển sang các status khác
 UPDATE orders
 SET status = in_new_status
 WHERE order_id = in_order_id;
 END IF;
 -- all ok thì 
 COMMIT;
END $$
DELIMITER ;
-- check
SELECT*FROM orders;
CALL sp_update_order_status_with_payment(3, 'completed', 500000, 'completed');  -- fail

DROP TRIGGER before_insert_check_payment;
DROP TRIGGER after_update_order_status;
DROP PROCEDURE sp_update_order_status_with_payment;