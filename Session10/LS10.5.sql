CREATE TABLE orders (
order_id INT primary key auto_increment,
customer_name VARCHAR(100),
total_amount DECIMAL(10,2), -- tổng tiền
order_date datetime default current_timestamp,
status_order ENUM('pending','shipping','completed','cancelled')
);
INSERT INTO orders(customer_name,total_amount,status_order) VALUE
('nguyen van a','12000000','cancelled');
SELECT*FROM orders;
CREATE TABLE order_logs (
log_id int primary key auto_increment,
order_id int not null,
FOREIGN KEY (order_id)
REFERENCES orders(order_id),
old_status VARCHAR(50),
new_status varchar(50),
log_date datetime default current_timestamp 
);
DELIMITER $$
CREATE TRIGGER after_order_status_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
   IF old.status_order <> new.status_order THEN
   INSERT INTO order_logs (order_id,old_status,new_status,log_date) VALUE
   (old.order_id,old.status_order,new.status_order,current_timestamp);
   END IF;
END $$
DELIMITER ;
-- check
-- sửa trạng thái
UPDATE orders SET status_order = 'pending' WHERE order_id = '1';
SELECT*FROM order_logs;  -- thành công ghi vào table order_log
-- chỉ sửa tên
UPDATE orders SET customer_name = 'nguyen van b' WHERE order_id = '1';
