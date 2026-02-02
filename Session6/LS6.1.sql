CREATE TABLE categories (
categori_id INT PRIMARY KEY NOT NULL,
categori_name VARCHAR(255) NOT NULL
);
CREATE TABLE products (
product_id int PRIMARY KEY NOT NULL,
product_name VARCHAR(255) NOT NULL,
price DOUBLE NOT NULL,
categori_id INT NOT NULL,
-- khóa ngoại
CONSTRAINT fk_pro_cate
FOREIGN KEY (categori_id)
REFERENCES categories (categori_id)
);
INSERT INTO categories (categori_id,categori_name) VALUE
('111','laptop'),
('112','smartphone'),
('113','smartphone');
INSERT INTO products(product_id,product_name,price,categori_id) VALUE
('001','macbook','20000000','111'),
('002','SonyY','12000000','112'),
('003','SamsungX','34000000','113');
-- cập nhật giá 
UPDATE products
SET price = '23000000'
WHERE product_id = '001';
SELECT*FROM products;
-- xóa 1 sản phẩm
DELETE FROM products
WHERE product_id = '002'; 
-- hiển thị add sản phẩm, sắp xếp theo giá
SELECT*FROM products
ORDER BY price ASC;
-- thống kê số lượng sp theo từng mục
SELECT 
c.categori_name AS 'danh mục',
COUNT(p.product_name) AS 'số lượng sản phẩm'
FROM categories c
LEFT JOIN products p ON c.categori_id = p.categori_id
GROUP BY c.categori_name;
