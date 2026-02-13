USE inventoryManagement;
DELIMITER $$
CREATE TRIGGER BeforeInsertProduct 
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF NEW.quantity < 0 THEN
  SIGNAL SQLSTATE '50001'
  SET MESSAGE_TEXT = 'không thể thêm số lượng sản phẩm <0';
  END IF;
END $$
DELIMITER ;
SELECT*FROM products;
-- check lại
INSERT INTO products(productName,quantity) VALUES 
('product7','-3'); -- thất bại