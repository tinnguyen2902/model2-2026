USE Lession11;
CREATE TABLE products (
id INT primary key auto_increment,
product_name VARCHAR(100),
price DECIMAL(10,2),
stock int -- số lượng tồn kho
);
INSERT INTO products (product_name,price,stock) VALUE
('Laptop gaming','20000000','10');

CREATE TABLE orders (
id int primary key auto_increment,
product_id int,
foreign key (product_id)
references products(id),
quantity int, -- số lượng mua
total_price decimal(10,2), -- tổng tiền = giá*số lượng
order_date datetime default current_timestamp 
);
DELIMITER $$
CREATE PROCEDURE place_order (
IN p_product_id int,
IN p_quantity int
)
BEGIN
-- gán số lượng tồn kho
  declare so_ton_kho int;
  -- gán giá
  DECLARE gia decimal(10,2);
  START TRANSACTION;
-- kiểm tra số lượng tồn kho
  SELECT stock,price
  INTO so_ton_kho,gia
  FROM products
  WHERE id = p_product_id;
-- kiểm tra sp trong kho đủ hay không  
  IF so_ton_kho < p_quantity THEN
    ROLLBACK;
    SELECT CONCAT('số lượng hàng không đủ. Số lượng hiện tại là:',so_ton_kho) AS message;
  ELSE -- ngược lại thì thực hiện giao dịch
    -- trừ số lương tồn kho ở bảng product
    UPDATE products
    SET stock=stock-p_quantity
    WHERE id = p_product_id;
    -- tạo bảng mới vào orders
    INSERT INTO orders (product_id,quantity,total_price) VALUE
    (p_product_id,p_quantity,gia*p_quantity );
    COMMIT;
    SELECT 'giao dịch thành công' AS message;
  END IF;
END $$
DELIMITER ;
SELECT*FROM products;
SELECT*FROM orders;
-- TH thành công
CALL place_order(1,2);
-- TH thất bại
CALL place_order(1,20);