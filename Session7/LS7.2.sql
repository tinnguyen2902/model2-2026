CREATE TABLE customers(
customerID VARCHAR(20) PRIMARY KEY NOT NULL,
customerName VARCHAR(100) NOT NULL
);
CREATE TABLE orders(
orderID VARCHAR(20) PRIMARY KEY NOT NULL,
orderDay DATETIME NOT NULL,
customerID VARCHAR(20) NOT NULL,
FOREIGN KEY (customerID)
REFERENCES customers(customerID) 
);
INSERT INTO customers (customerID,customerName) VALUE
('001','NGUYEN VAN A'),
('002','NGUYEN VAN B'),
('003','NGUYEN VAN C');
SELECT*FROM customers;
INSERT INTO orders (orderID,orderDay,customerID) VALUE
('OR01','2026-01-10 12:20:22','001'),
('OR02','2026-01-11 12:20:22','001'),
('OR03','2026-01-12 12:20:22','002'),
('OR04','2026-01-11 12:20:22','003');
SELECT*FROM orders;
CREATE VIEW v_order_info AS
SELECT o.orderID,
o.orderDay,
c.customerName
FROM customers c
JOIN orders o ON c.customerID= o.customerID; 
SELECT*FROM v_order_info;
