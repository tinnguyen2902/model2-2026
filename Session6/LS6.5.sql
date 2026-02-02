USE `Lession6.2`;
-- liệt kê sản phẩm cùng tên danh mục
SELECT 
p.product_name AS 'tên sản phẩm',
c.category_name AS 'loại'
FROM categories c
JOIN products p
ON c.category_id = p.category_id
ORDER BY c.category_name;
-- đếm số đơn từng khách
SELECT
c.customer_name AS 'tên khách hàng',
COUNT(order_id) AS 'số đơn hàng'
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY customer_name;
SELECT*FROM orders;
-- xác định 5 khách có doanh thu chi tiết cao nhất
SELECT 
c.customer_name AS 'tên khách hàng',
SUM(od.quantity*od.price) AS 'tổng doanh thu'
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY c.customer_name
ORDER BY 'tổng doanh thu' DESC
LIMIT 5;
-- tìm sản phẩm chưa xuất hiện ở đơn nào
SELECT
p.product_name AS 'tên sản phẩm'
FROM products p
LEFT JOIN order_details od
ON p.product_id = od.product_id
WHERE od.product_id IS NULL;
-- tìm khách đã mua sản phẩm thuộc danh mục có số lượng sản phẩm lớn nhất
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
WHERE od.product_id IN (
    -- Lấy các sản phẩm thuộc danh mục đó
    SELECT product_id 
    FROM products 
    WHERE category_id = (
        -- Tìm ID danh mục có nhiều sản phẩm nhất
        SELECT category_id 
        FROM products 
        GROUP BY category_id 
        ORDER BY COUNT(product_id) DESC 
        LIMIT 1
    )
);