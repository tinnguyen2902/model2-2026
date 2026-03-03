CREATE DATABASE Lession12 ;
USE Lession12 ;
CREATE TABLE customers (
customer_id INT primary key auto_increment,
name varchar(255)  not null,
email varchar(255) unique not null,
phone varchar(20),
address TEXT,
created_at timestamp default current_timestamp
);
SELECT*FROM customers;
CREATE TABLE orders (
order_id int primary key auto_increment not null,
customer_id int not null,
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id) ON DELETE CASCADE,
order_date timestamp default current_timestamp,
total_amount DECIMAL(10,2),
status ENUM('pending','completed','cancelled') DEFAULT 'pending'
);
SELECT*FROM orders;
CREATE TABLE products (
product_id int primary key auto_increment,
name varchar(255) not null,
price decimal(10,2) not null,
description text,
creted_at timestamp default current_timestamp
);
SELECT*FROM products;
CREATE TABLE order_items (
order_item_id int primary key auto_increment,
order_id int not null,
product_id int not null,
quantity int not null check (quantity>0),
price decimal(10,2) not null,
foreign key (order_id) references orders(order_id) ON DELETE CASCADE,
foreign key (product_id) references products(product_id)
);
SELECT*FROM order_items;
CREATE TABLE inventory (
product_id int primary key,
stock_quantity INT not null check(stock_quantity >= 0),
last_updated timestamp default current_timestamp ON UPDATE current_timestamp,
foreign key (product_id)
references products(product_id) ON DELETE CASCADE 
);
SELECT*FROM inventory;
CREATE TABLE payments (
payment_id int primary key auto_increment,
order_id int not null,
payment_date timestamp default current_timestamp,
amount decimal(10,2) not null,
payment_method enum('credit card','paypal','bank transfer','cash') not null,
status enum('pending','completed','failed') default 'pending',
foreign key (order_id) references orders(order_id) ON DELETE CASCADE
);
SELECT*FROM payments;
-- Trigger BEFORE INSERT:
DELIMITER $$
CREATE TRIGGER before_insert 
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
  -- gán giá trị hàng đang tồn tại
  DECLARE v_stock INT;
  -- lấy số lượng
  -- select... into: gán giá trị vào biến
  SELECT stock_quantity INTO v_stock
  FROM inventory
  WHERE product_id = NEW.product_id;
  -- kiểm tra tồn kho
  IF  v_stock < NEW.quantity THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'lỗi !!! số lượng tồn kho không đủ';
    END IF;
END $$
DELIMITER ;
-- text trigger hoạt động không
-- TH thành công
INSERT INTO order_items (order_id, product_id, quantity, price) 
VALUES (1, 1, 6, 1000.00);
-- TH thất bại
INSERT INTO order_items (order_id, product_id, quantity, price) 
VALUES (1, 1, 60, 1000.00);  -- đã hiện ra thông báo số lượng tồn kho không đủ

-- Trigger AFTER INSERT:
DELIMITER $$
CREATE TRIGGER after_insert 
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
   -- cập nhật lại cột total_amount
   UPDATE orders
   SET total_amount = total_amount+ (NEW.quantity*NEW.price)
   WHERE order_id = NEW.order_id;
END $$
DELIMITER ;
-- check bằng cách thêm sp mới
INSERT INTO order_items (order_id, product_id, quantity, price) 
VALUES (1, 1, 2, 5000000); 
SELECT*FROM order_items; 
-- trigger BEFORE UPDATE
DELIMITER $$
CREATE TRIGGER before_update
BEFORE UPDATE ON order_items
FOR EACH ROW
BEGIN
  declare v_stock int;
  -- lấy số lượng tồn khi
  SELECT stock_quantity INTO v_stock
  FROM inventory
  WHERE product_id = NEW.product_id;
  -- kt đk tông số hàng = ( số lượng có trong kho + số lượng đã đặt cũ)
  IF (v_stock + OLD.quantity ) < NEW.quantity THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'lỗi !!! số lượng tồn kho không đủ để thực hiện ';
    END IF;
END $$
DELIMITER ;
-- check: bây giờ tổng số hàng = 30 ; 
-- TH thành công
UPDATE order_items 
SET quantity = 10 
WHERE order_item_id = 1; 
-- Kết quả: Thành công (vì 10 <= 30).
-- TH thất bại
UPDATE order_items 
SET quantity = 100 
WHERE order_item_id = 1; 
-- Kết quả: Thành công (vì 100 <= 30).

-- trigger AFTER UPDATE
DELIMITER $$
CREATE TRIGGER after_update
AFTER UPDATE ON order_items
FOR EACH ROW
BEGIN
  -- check có gì thay đổi hay không
  IF (NEW.quantity != OLD.quantity) OR (NEW.price != OLD.price) THEN
  UPDATE orders 
  SET total_amount = total_amount + NEW.quantity*NEW.price-OLD.quantity*OLD.price
  WHERE order_id = NEW.order_id;
  END IF;
END $$
DELIMITER ;
-- check
SELECT*FROM order_items;
UPDATE order_items 
SET quantity = 3 
WHERE order_item_id = 1;
-- Món hàng này giờ trị giá: 3 * 12000000 = 36000000 (giảm từ 120tr xuống còn 36tr)
SELECT*FROM orders;

-- Trigger BEFORE DELETE: Tạo Trigger ngăn chặn việc xóa một đơn hàng có trạng thái Completed trong bảng orders. 
DELIMITER $$
CREATE TRIGGER before_delete
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
 IF OLD.status = completed THEN
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT = 'Lỗi không thể xóa đơn hàng ở trạng thái completed';
   END IF;
END $$
DELIMITER ;

-- Trigger AFTER DELETE:
DELIMITER $$
CREATE TRIGGER after_delete
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
  -- cập nhật lại số lượng tồn kho: cộng thêm số lượng vừa bị xóa
  UPDATE inventory
  SET stock_quantity = stock_quantity + OLD.quantity
  WHERE product_id = OLD.product_id;
END $$
DELIMITER ;

-- xóa các trigger
DROP TRIGGER before_insert;
DROP TRIGGER after_insert;
DROP TRIGGER before_update;
DROP TRIGGER after_update;
DROP TRIGGER before_delete;
DROP TRIGGER after_delete;