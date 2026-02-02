CREATE TABLE products (
product_id VARCHAR(20) PRIMARY KEY NOT NULL,
product_name VARCHAR(100) NOT NULL,
category VARCHAR(100) NOT NULL,
price DECIMAL(10,0)
);
INSERT INTO products(product_id,product_name,category,price)
VALUE ('001', 'Macbook2021','iphone',20000000),
('002', 'Macbook2022','iphone',15000000),
('003', 'Macbook2023','iphone',16000000),
('004', 'Macbook2024','iphone',22000000),
('005', 'Macbook2025','iphone',25000000),
('006', 'Samsung1','Samsung',12000000),
('007', 'Samsung2','Samsung',13000000),
('008', 'Sasmung3','Samsung',21000000),
('009', 'SonyX','sony',10000000),
('0010', 'SonyY','sony',22000000);
SELECT*FROM products;
-- hiển thị sp có giá cao hơn giá trung bình của sp
SELECT product_name AS 'Sản phẩm có giá cao hơn trung bình',price 'giá của sản phẩm'
FROM products
WHERE price > (SELECT AVG(price) FROM products);
-- hiển thị sp có giá cao nhất trong loại
SELECT product_name AS 'sản phẩm có giá cao nhất trong loại:', price 'giá'
FROM products AS p1
WHERE price = (SELECT MAX(price) FROM products AS p2 WHERE p2.category = p1.category);
-- giải thích : dùng p1 với p2 để định nghĩa bảng rồi sau đó lấy so sánh để đưa ra 3 kq, nếu không dùng sẽ chỉ trả về 1 kq đắt nhất trong all các loại
-- hiển thị các sp trong loại trên 20tr
SELECT product_name AS 'Tên', category AS 'loại', price AS 'giá'
FROM products
WHERE price >= '20000000';