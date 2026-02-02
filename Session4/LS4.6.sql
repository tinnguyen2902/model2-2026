CREATE TABLE products (
product_id VARCHAR(20) PRIMARY KEY NOT NULL,
product_name VARCHAR(100) NOT NULL,
category VARCHAR(200),
price decimal(10,0) NOT NULL,
quantity INT
);
-- thêm dữ liệu
INSERT INTO products(product_id,product_name,category,price,quantity)
VALUE 
('1','Iphone17','Iphone','20000000','200'),
('2','Macbook','Iphone','12000000','100'),
('3','SamsungFox','Laptop','15000000','200'),
('4','SamsungX','Samsung','13000000','0'),
('5','Sony','Laptop','10000000','0');
SELECT*FROM products;
-- truy vấn 
-- hiển thị sp có giá từ 5tr-15tr
SELECT*FROM products
WHERE price BETWEEN '5000000' AND '15000000';
-- hiển thị sp thuộc laptop or iphone
SELECT*FROM products
WHERE category IN ('Iphone','Laptop');
-- hiển thị sản phẩm có tên bắt đầu từ Sam
SELECT*FROM products
WHERE product_name LIKE 'Sam%';
-- hiển thị sản phẩm không thuộc iphone
SELECT*FROM products
WHERE category != 'iphone';
-- cập nhật & xóa
-- giảm 5% cho laptop
UPDATE products
SET price = price*0.95
WHERE category = 'laptop';
SELECT*FROM products
-- xóa tồn kho bằng 0
DELETE FROM products
WHERE quantity = '0';
SELECT*FROM products