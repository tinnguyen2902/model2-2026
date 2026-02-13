CREATE TABLE orders (
order_id INT primary key auto_increment not null,
customer_id int not null,
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),
product_id int not null,
FOREIGN KEY (product_id)
REFERENCES products(product_id),
quantity int not null CHECK(quantity >0),
total_amount double not null CHECK(total_amount >0),
stutus ENUM('pending','success','cancel') DEFAULT 'pending'
);
CREATE VIEW view_customer_spending AS
SELECT c.customer_id, 
c.customer_name,
COUNT(o.order_id) AS total_orders,
IFNULL(SUM(o.total_amount),0)  AS total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name, c.customer_id;
SELECT*FROM view_customer_spending;