SELECT*FROM orders;
ALTER TABLE orders
ADD COLUMN status ENUM('pending','shipping','completed','cancelled') default ('pending');
DELIMITER $$
CREATE PROCEDURE cancel_order (
IN p_order_id int
)
BEGIN
   -- khai báo biến để lưu thông tin đơn hàng
   declare v_product_id int;
   declare v_quantity int;
   declare v_current_status ENUM('pending','shipping','completed','cancelled') default ('pending');
   -- xử lý lỗi hệ thống
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
     rollback;
     SELECT 'lỗi hệ thống. thao tác lại !!!' AS message;
   END;
   -- bắt đầu giao dịch
   START TRANSACTION;
   -- lấy thông tin đơn hàng
   SELECT product_id,quantity,status
   INTO v_product_id,v_quantity,v_current_status
   FROM orders
   WHERE id = p_order_id
   FOR UPDATE;
   -- kiểm tra điều kiện
   IF v_product_id IS NULL THEN
   ROLLBACK;
   SELECT 'không tìm thấy đơn hàng' AS message;
   ELSEIF v_current_status = 'cancelled' THEN
   ROLLBACK;
   SELECT 'đơn đã hủy trước đó' AS message;
   ELSE
     -- TH có đơn hủy
     -- cập nhật đơn hủy
     UPDATE orders
     SET status = 'cancelled'
     WHERE id = p_order_id;
     -- hoàn hàng về kho
      UPDATE products 
	  SET stock = stock + v_quantity 
	  WHERE id = v_product_id;
      COMMIT;
	  SELECT 'Hủy đơn hàng thành công! Đã hoàn tồn kho.' AS message;
    END IF;
END $$
DELIMITER ;
SELECT*FROM orders;
SELECT*FROM products;
-- TH thành công
CALL cancel_order(1);
-- TH. thất bại
CALL cancel_order(2);