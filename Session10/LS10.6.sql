USE InventoryChanges;
SELECT*FROM products;
CREATE TABLE cart_items (  -- chi tiết giỏ hàng
id int primary key auto_increment,
product_id int,
foreign key (product_id)
references products(productID),
quantity int  -- số lượng khách muốn mua
);
SELECT*FROM cart_items;
DELIMITER $$
CREATE TRIGGER before_cart_add
BEFORE INSERT ON cart_items
FOR EACH ROW
BEGIN
-- khai báo biến mới
  DECLARE product_stock int;
  -- lấy tồn kho từ bảng products
  SELECT stock
  INTO product_stock
  FROM products
  WHERE productID = new.product_id;
  -- th thiếu 
  IF new.quantity > product_stock THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'số lượng hàng trong kho không đủ để thêm vào giỏ hàng';
  END IF ;
END $$
DELIMITER ;
INSERT INTO cart_items (product_id, quantity)
VALUES (2, 10);
