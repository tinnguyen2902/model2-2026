CREATE TABLE products(
id int primary key not null,
full_name VARCHAR(100) not null,
price double not null,
category varchar(255) 
);
INSERT INTO products (id,full_name,price,category) VALUE
('1','macbook','12000000','laptop'),
('2','macbook1','13000000','laptop'),
('3','macbook2','14000000','smartphone'),
('4','macbook3','15000000','samsung');
DELIMITER $$
CREATE PROCEDURE sp_get_products_by_category(IN p_category varchar(255))
BEGIN
SELECT*FROM products
WHERE p_category = category;
END$$
DELIMITER ;
CALL sp_get_products_by_category('laptop');