USE Lession12;
-- Stored Procedure sp_create_order 
DELIMITER $$
CREATE PROCEDURE sp_create_order(
IN p_customer_id int,   -- ai mua?
IN p_product_id int,   -- mua cái gì?
IN p_quantity int,    -- mua bao nhiêu?
IN p_price int     -- giá bao nhiêu?
)
BEGIN
-- khai báo biến
  DECLARE v_stock int;
  DECLARE v_order_id int;
  DECLARE v_total_amount DECIMAL(15,2);
  START TRANSACTION;
  -- lấy thông tin đơn hàng
  SELECT stock_quantity INTO v_stock
  FROM inventory
  WHERE product_id = p_product_id 
  FOR UPDATE;
  -- so sánh số lượng hàng
  -- nếu k đủ
  IF v_stock IS NULL OR v_stock < p_quantity THEN     -- nếu số hàng còn lại = 0 or số hàng còn lại nhỏ hơn số lượng nhập vào
  ROLLBACK;
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'lỗi !!! số lượng còn lại không đủ or sản phẩm không tồn tại';
  ELSE
  -- nếu đủ => tạo đơn = thêm vào orders
  SET v_total_amount = p_quantity * p_price;
  INSERT INTO orders(customer_id,total_amount,status) VALUE
  (p_customer_id,v_total_amount,'pending');
  -- lấy id vừa tạo với mục đích kết nối bảng orders vs order_items (chi tiết từng món hàng) 
  SET v_order_id = LAST_INSERT_ID();
  -- thêm vào bàng order_item
  INSERT INTO order_items(order_id,product_id,quantity,price) VALUE
  (v_order_id,p_product_id,p_quantity,p_price);
  -- cập nhật kho
  UPDATE inventory
  SET stock_quantity = stock_quantity-p_quantity
  WHERE product_id = p_product_id;
  COMMIT;
  END IF;
END $$
DELIMITER ;
-- check 
CALL sp_create_order(1,1,1,120000);
SELECT*FROM orders;
SELECT*FROM order_items;
SELECT*FROM inventory;

-- Stored Procedure sp_pay_order:
DELIMITER $$
CREATE PROCEDURE sp_pay_order(
IN in_order_id int,
IN in_payment_method enum('credit card','paypal','bank transfer','cash')
)
BEGIN
  DECLARE v_status ENUM('pending','completed','cancelled');
  DECLARE v_amount DECIMAL(15,2);
  -- bắt đầu giao dịch
  START TRANSACTION;
  -- check trạng thái + số tiền
  SELECT status,total_amount INTO v_status, v_amount
  FROM orders
  WHERE order_id = in_order_id
  FOR UPDATE;  -- sử dụng for update để khóa dòng, tránh thanh tóa trùng lặp
  -- check đk thanh tóa
  IF v_status IS NULL THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'lỗi !!! đơn hàng không tồn tại';
  ELSEIF v_status <> 'pending' THEN
   ROLLBACK;
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT = 'lỗi !!! tình trạng đơn không phải là pending';
  else
    -- TH ok
    INSERT INTO payments (order_id,amount,payment_method,status) VALUE
    (in_order_id,v_amount,in_payment_method,'completed');
    UPDATE orders
    SET status = 'completed'
    WHERE order_id = in_order_id;
    COMMIT;
   END IF; 
END $$
DELIMITER ;
-- check TH OK 
CALL sp_pay_order(1, 'bank transfer');
SELECT*FROM orders;
SELECT*FROM payments;
-- check TH NG hiện ra thông báo lỗi tình trạng đơn hàng không phải là pendding
CALL sp_pay_order(1, 'cash');
-- Stored Procedure sp_cancel_order:
DELIMITER $$
CREATE PROCEDURE sp_cancel_order (
IN in_order_id INT
)
BEGIN
  DECLARE v_status ENUM('pending','completed','cancelled');
  START TRANSACTION;
  -- check status đơn
  SELECT status INTO v_status
  FROM orders
  WHERE order_id = in_order_id
  FOR UPDATE ;
  -- check status chỉ hủy đơn pending thôi
  IF v_status IS NULL THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Lỗi!!! Đơn hàng không tồn tại!';
 ELSEIF v_status <> 'pending' THEN
	ROLLBACK;
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Lỗi!!! Chỉ hủy Đơn hàng pending!';
else
   UPDATE  inventory i
   JOIN order_items oi ON i.product_id = oi.product_id
   SET i.stock_quantity = i.stock_quantity + oi.quantity
   WHERE oi.order_id = p_order_id;  
   -- xóa các sp liên quan
   DELETE FROM order_items 
   WHERE order_id = in_order_id;
   COMMIT;
END IF;
END $$
DELIMITER ;
 -- check
SELECT*FROM inventory;
CALL sp_cancel_order(1); -- lỗi do status không phải là pending

-- xóa các procedure
DROP PROCEDURE sp_cancel_order;
DROP PROCEDURE sp_create_order;
DROP PROCEDURE sp_pay_order;