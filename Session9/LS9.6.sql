USE Lession9;
SELECT*FROM customers;
SELECT*FROM orders;
SELECT*FROM products;
DROP PROCEDURE add_order;
DELIMITER $$
CREATE PROCEDURE add_order (
IN in_customer_id int,
IN in_product_id int,
IN in_quantity int,
OUT out_message VARCHAR(255)
)
BEGIN
   -- gán biến 
    DECLARE v_stock INT;
    DECLARE v_price decimal(15,2);
   -- lấy số lượng tồn kho
    SELECT stock
    INTO v_stock
    FROM products
    WHERE product_id = in_product_id;
    -- kiểm tra sản phẩm tồn tại
    IF v_stock IS NULL THEN
        SET out_message = 'Sản phẩm không tồn tại';
    -- kiểm tra đủ tồn kho không
    ELSEIF v_stock < in_quantity THEN
        SET out_message = 'Không đủ số lượng sản phẩm để đặt hàng.';
    ELSE
        -- tạo đơn hàng
        INSERT INTO orders (customer_id, product_id, quantity,total_amount,stutus,stutus )
        VALUES (in_customer_id, in_product_id, in_quantity,v_price*in_quantity,'pending' );
        -- trừ tồn khoorders
        UPDATE products
        SET stock = stock - in_quantity
        WHERE product_id = in_product_id;
        SET out_message = 'Thêm đơn hàng thành công!';
    END IF;
END $$
DELIMITER ;
CALL add_order(1, 1, 2, @message);
SELECT @message;