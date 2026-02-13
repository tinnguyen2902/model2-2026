CREATE SCHEMA `InventoryChanges` ;
CREATE TABLE products (
productID int primary key not null,
productName varchar(100) not null,
quantity int not null
);
CREATE TABLE inventoryChanges (
changeID int AUTO_INCREMENT primary key not null,
productID int not null,
oldQuantity int not null,
newQuantity int not null,
changeDDate datetime not null,
CONSTRAINT pro_inv
FOREIGN KEY (productID) REFERENCES products(productID)
);
INSERT INTO products (productID,productName,quantity) VALUE
('1','name1','20');
DELIMITER $$
CREATE TRIGGER AfterProductUpdate 
AFTER INSERT ON products
FOR EACH ROW 
BEGIN
    -- Vì là sản phẩm mới hoàn toàn, nên oldQuantity sẽ là 0
    INSERT INTO inventoryChanges (productID, oldQuantity, newQuantity, changeDDate)
    VALUES (
        NEW.productID, 
        0,                -- Số lượng cũ là 0 vì mới tạo
        NEW.quantity,     -- Số lượng mới nhập
        NOW()             -- Thời gian hiện tại
    );
END $$
DELIMITER ;
SELECT*FROM products;
INSERT INTO products (productID,productName,quantity) VALUE
('2','name2','40');
SELECT*FROM inventoryChanges;
