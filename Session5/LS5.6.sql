CREATE TABLE customersLS5 (
customer_id VARCHAR(20) PRIMARY KEY NOT NULL,
customer_name VARCHAR(100) NOT NULL
);
CREATE TABLE ordersLS5 (
order_id VARCHAR(20) PRIMARY KEY NOT NULL,
order_date TIMESTAMP NOT NULL,
customer_id VARCHAR(20) NOT NULL,
-- thiết lập khóa ngoại
CONSTRAINT fk_order_customerLS5
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
); 
CREATE TABLE order_itemsLS5 (
order_id VARCHAR(20) NOT NULL,
customer_id VARCHAR(20) NOT NULL,
product_name VARCHAR(100),
quantity VARCHAR(100),
price DECIMAL(10,0),
-- khóa chính
PRIMARY KEY (customer_id,order_id),
-- khóa ngoại
CONSTRAINT fk_customer_itemsLS5
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),
CONSTRAINT fk_order_itemsLS5
FOREIGN KEY (order_id)
REFERENCES orders(order_id)
);
INSERT INTO customersLS5 (customer_id, customer_name) 
VALUES
('C001', 'Nguyễn Văn Anh'),
('C002', 'Trần Thị Bình'),
('C003', 'Lê Minh Tâm');
INSERT INTO ordersLS5 (order_id, order_date, customer_id) VALUES
('ORD01', '2026-01-20 09:30:00', 'C001'),
('ORD02', '2026-01-21 14:15:00', 'C001'),
('ORD03', '2026-01-22 10:00:00', 'C002');
INSERT INTO order_itemsLS5 (order_id, customer_id, product_name, quantity, price) VALUES
('ORD01', 'C001', 'iPhone Pro', '1', 2500000),
('ORD02', 'C001', 'Macbook M3', '1', 35000000),
('ORD03', 'C002', 'Samsung S24', '2', 21000000);
-- hiển thị mã đơn hàng, tên khách, tổng tiền
SELECT 
o.order_id AS 'mã đơn',
c.customer_name AS 'tên khách hàng',
SUM(oi.quantity*oi.price) AS 'tổng số tiền của đơn hàng'
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_itemsLS5 oi
ON o.order_id = oi.order_id
GROUP BY o.order_id,c.customer_name;
-- tổng doanh thu mỗi khách hàng
SELECT 
c.customer_name AS 'tên khách hàng',
SUM(oi.quantity*oi.price) AS 'tổng doanh thu'
FROM customersLS5 c
JOIN ordersLS5 o
ON o.customer_id = c.customer_id
JOIN order_itemsLS5 oi
ON o.order_id = oi.order_id
GROUP BY c.customer_name;
-- chỉ hiển thị khách có tổng doanh thu lớn hơn 20tr
SELECT 
c.customer_name AS 'tên khách hàng',
SUM(oi.quantity*oi.price) AS 'tổng doanh thu'
FROM customersLS5 c
JOIN ordersLS5 o
ON o.customer_id = c.customer_id
JOIN order_itemsLS5 oi
ON o.order_id = oi.order_id
GROUP BY c.customer_name
HAVING SUM(oi.quantity * oi.price) > 20000000;
-- hiển thị khách có doanh thu có nhất
SELECT 
c.customer_name AS 'tên khách hàng',
SUM(oi.quantity*oi.price) AS 'tổng doanh thu'
FROM customersLS5 c
JOIN ordersLS5 o
ON o.customer_id = c.customer_id
JOIN order_itemsLS5 oi
ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY SUM(oi.quantity*oi.price) DESC
LIMIT 1;
