CREATE DATABASE inventoryManagement;
USE inventoryManagement;
CREATE TABLE products (
productID integer auto_increment primary key not null,
productName varchar(100) not null,
quantity integer not null
);
SELECT*FROM products;
CREATE TABLE inventoryChanges (
changeID integer auto_increment primary key not null,
productID integer not null,
FOREIGN KEY (productID)
REFERENCES products(productID),
oldQuantity integer not null,
newQuantity integer not null,
changeDate datetime not null
);
SELECT*FROM inventoryChanges;
DELIMITER $$
CREATE TRIGGER beforeProductDelete 
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
IF OLD.quantity > 10 THEN
SIGNAL SQLSTATE '50000'
SET MESSAGE_TEXT='không thể xóa sản phẩm có số lượng còn lại lớn hơn 10';
END IF;
END$$
DELIMITER ;
DELETE FROM products WHERE productID=4;  -- thành công
DELETE FROM products WHERE productID=1;  -- thất bại


