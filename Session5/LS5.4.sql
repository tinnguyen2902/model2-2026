CREATE TABLE customers (
customer_id VARCHAR(20) PRIMARY KEY NOT NULL,
customer_name VARCHAR(100) NOT NULL
);
CREATE TABLE orders (
order_id VARCHAR(20) PRIMARY KEY NOT NULL,
order_date TIMESTAMP NOT NULL,
customer_id VARCHAR(20) NOT NULL,
-- thiết lập khóa ngoại
CONSTRAINT fk_order_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
); 
CREATE TABLE order_items (
order_id VARCHAR(20) NOT NULL,
customer_id VARCHAR(20) NOT NULL,
product_name VARCHAR(100),
quantity VARCHAR(100),
price DECIMAL(10,0),
-- khóa chính
PRIMARY KEY (customer_id,order_id),
-- khóa ngoại
CONSTRAINT fk_customer_items
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),
CONSTRAINT fk_order_items
FOREIGN KEY (order_id)
REFERENCES orders(order_id)
);
INSERT INTO customers (customer_id, customer_name) 
VALUES
('C001', 'Nguyễn Văn Anh'),
('C002', 'Trần Thị Bình'),
('C003', 'Lê Minh Tâm');
SELECT*FROM customers;
INSERT INTO orders (order_id, order_date, customer_id) VALUES
('ORD01', '2026-01-20 09:30:00', 'C001'),
('ORD02', '2026-01-21 14:15:00', 'C001'),
('ORD03', '2026-01-22 10:00:00', 'C002');
SELECT*FROM orders;
INSERT INTO order_items (order_id, customer_id, product_name, quantity, price) VALUES
('ORD01', 'C001', 'iPhone Pro', '1', 2500000),
('ORD02', 'C001', 'Macbook M3', '1', 35000000),
('ORD03', 'C002', 'Samsung S24', '2', 21000000);
SELECT*FROM order_items;
-- hiển thị mã đơn hàng, ngày đặt, tên khách
SELECT 
o.order_id AS 'mã đơn hàng',
o.order_date AS 'ngày đặt hàng',
c.customer_name AS 'tên khách hàng'
FROM orders o
INNER JOIN customers c
ON o.customer_id =c.customer_id;
-- hiển thị danh sách sản phẩm trong mỗi đơn
SELECT
o.order_id AS 'mã đơn hàng',
oi.product_name AS 'sản phẩm'
FROM orders o
INNER JOIN order_items oi
ON o.customer_id = oi.customer_id;
-- hiển thị tổng số tiền trên mỗi đơn
SELECT
o.order_id AS 'mã đơn hàng',
c.customer_name AS 'họ và tên',
SUM(oi.price*oi.quantity) AS 'tổng số tiền'
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
LEFT JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY o.order_id,c.customer_name; 
-- bắt buộc phải có group khi dùng sum
-- hiển thị đơn hàng lớn hơn 10tr
SELECT 
o.order_id AS 'Mã đơn',
c.customer_name AS 'Khách hàng',
SUM(oi.quantity * oi.price) AS 'Tổng tiền đơn hàng'
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.order_id, c.customer_name
HAVING SUM(oi.quantity * oi.price) > 10000000;