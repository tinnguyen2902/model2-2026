CREATE TABLE customers (
customer_id int primary key not null,
customer_name varchar(255) not null,
email varchar(255) 
);
CREATE TABLE orders (
order_id int primary key not null,
customer_id int not null,
order_date date not null,
-- khóa phụ
constraint fk_orde_customers -- b1: tên khóa phụ
foreign key (customer_id)  -- khóa phụ
references customers(customer_id) -- table liên kết
);
CREATE TABLE categories (
category_id int primary key not null,
category_name varchar(255) not null
);
CREATE TABLE products (
product_id int primary key not null,
product_name varchar(255) not null,
price double not null,
category_id int not null,
-- khóa phụ
constraint fk_cate_pro
foreign key (category_id)
references categories(category_id)
);
CREATE TABLE order_details (
order_id int not null,
product_id int not null,
quantity int not null,
price double not null,
primary key (order_id,product_id),
-- tương tự tạo 2 khóa phụ cho mỗi khóa chính
constraint fk_order_details
foreign key (order_id)
references orders(order_id),
constraint fk_order_product
foreign key (product_id)
references products(product_id) 
);
INSERT INTO customers (customer_id,customer_name,email) VALUE
('1','Nguyen van a','a＠gmail.com'),
('2','Le van a','lea＠gmail.com');
INSERT INTO customers (customer_id,customer_name,email) VALUE
('3','Tran C','cc＠gmail.com'),
('4','Tran Thi C','cd＠gmail.com');
SELECT*FROM customers;
INSERT INTO orders (order_id,customer_id,order_date) VALUE
('10','1','2026-01-10 12:12:12'),
('11','1','2026-02-10 12:12:12'),
('12','2','2026-01-12 12:12:12'),
('13','2','2026-01-13 12:12:12'),
('14','2','2026-01-15 12:12:12'),
('15','1','2026-01-13 12:12:12');
SELECT*FROM orders;
INSERT INTO categories (category_id,category_name)VALUE
('1001','laptop'),
('1002','laptop'),
('1003','iphone'),
('1004','iphone'),
('1005','samsung');
DELETE FROM categories
WHERE category_id IN ('1002','1004');
SELECT*FROM categories;
INSERT INTO products(product_id,product_name,price,category_id) VALUE
('201','iphone12','15000000','1003'),
('202','iphone15','25000000','1003'),
('203','samusungX','22000000','1001'),
('204','macbookX','25000000','1001'),
('205','ssamsung14','18000000','1005');
SELECT*FROM products;
INSERT INTO order_details (order_id,product_id,quantity,price) VALUE
-- orderid(10->15) productId('201=>205')
('10','201','2','18000000'),
('11','202','1','23000000'),
('12','203','3','23000000'),
('13','204','4','30000000'),
('14','205','2','30000000'),
('15','201','3','39000000');
SELECT*FROM order_details;
-- liệt kê khách hàng có trên 1 đơn
SELECT c.customer_name AS 'Tên khách hàng',  -- hiện ra gì
COUNT(o.customer_id) AS 'số lần mua hàng'
FROM customers c                            -- từ đâu
INNER JOIN orders o                         -- join thêm vào đâu
ON c.customer_id = o.customer_id
GROUP BY c.customer_name,c.customer_id     -- nhóm dữ liệu gì
HAVING COUNT(o.customer_id)>1;             -- thêm điều kiện gì
-- giải thích: dùng inner join thì giao nhau customer_id 
-- liệt kê khách chưa đặt đơn nào
SELECT c.customer_name AS 'tên khách hàng'
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) = 0;
-- tổng doanh thu mỗi khách
SELECT c.customer_name AS 'tên khách hàng',
SUM(od.quantity*od.price) AS 'Tông doanh thu 1 khách'
FROM orders o
LEFT JOIN customers c
ON c.customer_id = o.customer_id
LEFT JOIN order_details od
ON o.order_id = od.order_id
GROUP BY c.customer_name;
-- xác định khách đã mua sp có giá cao nhất
SELECT c.customer_name AS 'tên khách hàng',
p.product_name AS 'tên sản phẩm',
od.price AS 'giá sản phẩm'
FROM order_details od
JOIN orders o                -- chú ý thứ tự orders ->customers => product
ON o.order_id=od.order_id
JOIN customers c
ON c.customer_id=o.customer_id
JOIN products p
ON od.product_id=p.product_id
WHERE od.price = (SELECT MAX(price) FROM order_details);