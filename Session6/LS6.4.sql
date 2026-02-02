USE `Lession6.2`;
SELECT*FROM orders;
-- thêm đơn mới
INSERT INTO orders(order_id,customer_id,order_date) VALUE
('16','1','2026-02-12');
SELECT*FROM order_details;
INSERT INTO order_details(order_id,product_id,quantity,price) VALUE
('16','205','1','25000000');
-- tính tổng doanh thu của toàn bộ cửa hàng
SELECT 
SUM(quantity*price) AS 'tổng doanh thu một tháng'
FROM order_details;
-- tính doanh thu trung bình mỗi đơn
SELECT 
product_name AS 'sản phẩm',
AVG(quantity*price) AS 'trung bình doanh thu một đơn'
FROM order_details;
-- tìm và hiển thị đơn có doanh thu cao nhất
SELECT 
product_name AS 'tên sản phẩm',
(od.quantity*od.price) AS 'đơn có doanh thu cao nhất'
FROM order_details od
INNER JOIN products p
ON od.product_id = p.product_id
ORDER BY `đơn có doanh thu cao nhất` DESC
LIMIT 1;
-- tìm & hiển thị 3 sản phẩm bán chạy dựa theo số lượng 
SELECT
product_name AS 'tên sản phẩm',
quantity AS 'số lượng'
FROM order_details od
INNER JOIN products p
ON od.product_id = p.product_id
ORDER BY `số lượng`  DESC
LIMIT 3;
