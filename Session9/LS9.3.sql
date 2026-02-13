CREATE TABLE products (
product_if int auto_increment primary key,
product_name varchar(50) not null,
price decimal(10,2) check (price>0) not null,
stock int check (stock > 0) not null
);
INSERT INTO products (product_name, price, stock) VALUES
('Product 1', 500000.00, 10),
('Product 2', 1500000.00, 5),
('Product 3', 2000000.00, 8),
('Product 4', 300000.00, 20),
('Product 5', 2500000.00, 15),
('Product 6', 800000.00, 12),
('Product 7', 1200000.00, 7),
('Product 8', 1000000.00, 3),
('Product 9', 1750000.00, 6),
('Product 10', 950000.00, 4),
('Product 11', 450000.00, 9),
('Product 12', 1100000.00, 13),
('Product 13', 500000.00, 20),
('Product 14', 999999.99, 12),
('Product 15', 3500000.00, 6),
('Product 16', 120000.00, 23),
('Product 17', 5555555.00, 8),
('Product 18', 1700000.00, 5),
('Product 19', 850000.00, 7),
('Product 20', 2000000.00, 10);
SELECT*FROM products;
DELIMITER $$
CREATE PROCEDURE get_high_value_products()
BEGIN
    SELECT*FROM products
    WHERE price>1000000;
END$$
DELIMITER ;
CALL get_high_value_products;