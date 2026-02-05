CREATE TABLE ordersLS76 (
id VARCHAR(20) PRIMARY KEY NOT NULL,
order_day DATE NOT NULL,
order_status ENUM('pending', 'paid', 'shipping', 'completed', 'canceled') DEFAULT 'pending',
price DOUBLE NOT NULL
);
INSERT INTO ordersLS76(id,order_day,order_status,price) VALUES
('1','2023-12-11','paid','12000'),
('2','2024-12-11','shipping','1100000'),
('3','2024-10-11','canceled','200000');
SELECT*FROM ordersLS76;
CREATE INDEX idx_status_day 
ON ordersLS76(order_status,order_day);