USE Lession7;
CREATE TABLE products (
product_id int PRIMARY KEY NOT NULL,
product_name VARCHAR(255) NOT NULL,
categori INT NOT NULL,
price DOUBLE NOT NULL
);
CREATE INDEX idx_ket_hop 
ON products (categori,price);