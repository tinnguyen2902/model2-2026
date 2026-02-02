CREATE TABLE products63 (
product_id INT PRIMARY KEY NOT NULL,
product_name VARCHAR(255) NOT NULL,
price double NOT NULL,
category VARCHAR(255) NOT NULL 
);
INSERT INTO products63(product_id,product_name,price,category) VALUE
('1','iphone12','12000000','smartphone'),
('2','samsungX','16000000','smartphone'),
('3','Mac12','12000000','laptop'),
('4','Abc12','12000000','laptop'),
('5','smarrt1','2000000','smartwatch'),
('6','watch2','4000000','smartwatch');
SELECT*FROM products63;
-- tìm sản phẩm giá nằm trong khoảng 5tr-15tr
SELECT 
product_name AS 'tên sản phẩm',
price AS 'giá',
category AS 'loại'
FROM products63
WHERE price BETWEEN 5000000 AND 15000000;
-- tìm sản phẩm 
SELECT 
product_name AS 'tên sản phẩm',
price AS 'giá',
category AS 'loại'
FROM products63
WHERE product_name NOT LIKE 'S%';
-- giá trung bình mỗi loại
SELECT 
category AS 'loại',
AVG(price) AS 'giá trung bình'
FROM products63
GROUP BY category;
-- tìm sản phẩm có giá cao hơn giá tb
SELECT*FROM (
SELECT
product_name AS 'tên sản phẩm',
price AS 'giá',
category AS 'loại',
-- tính trung bình từng loại
AVG(price) OVER(PARTITION BY category) AS gia_trung_binh
FROM products63 ) AS temp
WHERE `giá` > gia_trung_binh;
-- tìm sản phẩm giá thấp nhất trong từng danh mục
SELECT 
product_name AS 'tên sản phẩm',
category AS 'loại',
price AS 'giá'
FROM products63
WHERE (category,price) IN (
SELECT category, MIN(price)
FROM products63
GROUP BY category);

