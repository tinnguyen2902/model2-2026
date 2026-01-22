CREATE TABLE ordersLS16 (
OrderID VARCHAR(10) PRIMARY KEY,
OrderDay DATE NOT NULL,
OrderStatus ENUM('NEW','PAID') 
);
CREATE TABLE SanPham(
ProductID VARCHAR(10) PRIMARY KEY,
ProductName VARCHAR(30) NOT NULL,
Price DECIMAL(10,2) NOT NULL
);
CREATE TABLE order_Product (
OrderID VARCHAR(10),
ProductID VARCHAR(10),
Quantity INT, 
-- primary kép
PRIMARY KEY(OrderID,ProductID),
-- thiết lập ràng buộc
CONSTRAINT orderItem FOREIGN KEY (orderID)
REFERENCES ordersLS16(OrderID),
CONSTRAINT productItem FOREIGN KEY (ProductID)
REFERENCES Sanpham(ProductID)
);