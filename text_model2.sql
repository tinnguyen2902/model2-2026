CREATE DATABASE text_model_2;
USE text_model_2;
-- 1
CREATE TABLE customer (
customer_id varchar(5) primary key NOT NULL,
customer_full_name  varchar(100) NOT NULL,
customer_email varchar(100) UNIQUE NOT NULL,
customer_phone varchar(15) NOT NULL,
customer_address varchar(255) NOT NULL
);
CREATE TABLE room (
room_id varchar(5) PRIMARY KEY NOT NULL,
room_type varchar(50) NOT NULL,
room_price decimal(10,2) NOT NULL,
room_status varchar(20) NOT NULL,
room_area int not null
);
CREATE TABLE booking (
booking_id int primary key auto_increment not null ,
customer_id varchar(5) not null,
foreign key (customer_id) REFERENCES customer(customer_id),
room_id varchar(5) not null,
foreign key (room_id) references room(room_id),
check_in_date date not null,
check_out_date date not null,
total_amount decimal(10,2)
);
CREATE TABLE payment (
payment_id int primary key not null auto_increment,
booking_id int not null,
foreign key (booking_id) references booking(booking_id),
payment_method varchar(50) not null,
payment_date date not null,
payment_amount decimal(10,2) not null
);
-- 2
INSERT INTO customer(customer_id,customer_full_name,customer_email,customer_phone,customer_address) values
('C001','NGUYEN ANH TU','tu.nguyen@example.com','0912345678','Hanoi, VietNam'),
('C002','Tran Thi Mai','mai.tran@example.com','0923456789','Ho Chi Minh, Vietnam'),
('C003','Le Minh Hoang','hoang.le@example.com','0934567890','Danang, Vietnam'),
('C004','Pham Hoang Nam','nam.pham@example.com','0945678901','Hue, Vietnam'),
('C005','Vu Minh Thu','thu.vu@example.com','0956789012','Hai Phong, Vietnam'),
('C006','Nguyen Thi Lan','lan.nguyen@example.com','0967890123','Quang ning, vietnam'),
('C007','Bui Minh Tuan','tuan.bui@example.com','0967890123','BacGiang, VietNam'),
('C008','Pham Quang Hieu','hieu.pham@example.com','0967890123','QuangNam VietNam'),
('C009','Le Thi Lan','lan.le@example.com','0967890123','DaLat VietNam'),
('C010','Nguyen Thi Mai','mai.nguyen@example.com','0967890123','Can Tho Viet Nam');
INSERT INTO room(room_id,room_type,room_price,room_status,room_area) VALUES
('R001','single','100.0','Available','25'),
('R002','double','150.0','Booked','40'),
('R003','suite','250.0','Available','60'),
('R004','single','120.0','Booked','30'),
('R005','double','160.0','Available','35');
INSERT INTO booking(customer_id,room_id,check_in_date,check_out_date,total_amount) VALUES
('C001','R001','2025-03-01','2025-03-05','400'),
('C002','R002','2025-03-02','2025-03-06','600'),
('C003','R003','2025-03-03','2025-03-07','1000'),
('C004','R004','2025-03-04','2025-03-08','480'),
('C005','R005','2025-03-05','2025-03-09','800'),
('C006','R001','2025-03-06','2025-03-10','400'),
('C007','R002','2025-03-07','2025-03-11','600'),
('C008','R003','2025-03-08','2025-03-12','1000'),
('C009','R004','2025-03-09','2025-03-13','480'),
('C010','R005','2025-03-10','2025-03-14','800');
INSERT INTO payment(booking_id,payment_method,payment_date,payment_amount) VALUES
('1','Cash','2025-03-05','400'),
('2','Credit Card','2025-03-06','600'),
('3','Bank Trasfer','2025-03-07','1000'),
('4','Cash','2025-03-08','480'),
('5','Credit Card','2025-03-09','800'),
('6','Bank Trasfer','2025-03-10','400'),
('7','Cash','2025-03-11','600'),
('8','Credit Card','2025-03-12','1000'),
('9','Bank Trasfer','2025-03-13','480'),
('10','Cash','2025-03-14','800');
-- 3. cập nhật dữ liệu
UPDATE booking b
INNER JOIN room r ON b.room_id = r.room_id
SET b.total_amount = r.room_price * DATEDIFF(b.check_out_date, b.check_in_date)
WHERE r.room_status = 'Booked'
AND b.check_in_date < CURDATE();
-- xóa dữ liệu
DELETE FROM payment
WHERE payment_method = 'Cash'
AND payment_amount < 500;
-- p2
-- 5
SELECT*FROM customer
ORDER BY customer_full_name ASC;
-- 6
SELECT room_id,room_type,room_price,room_area
FROM room
ORDER BY room_price DESC;
-- 7
SELECT c.customer_id,c.customer_full_name,
       b.room_id,b.check_in_date,b.check_out_date
FROM customer c
JOIN booking b ON c.customer_id = b.customer_id;
-- 8
SELECT c.customer_id AS ma_khach_hang, 
       c.customer_full_name AS ho_va_ten,
       p.payment_method AS cach_thanh_toan ,
       p.payment_amount AS so_tien
FROM customer c
INNER JOIN booking b 
ON c.customer_id = b.customer_id
INNER JOIN payment p 
ON b.booking_id = p.booking_id   
ORDER BY p.payment_amount DESC;   
-- 9
SELECT*FROM customer
ORDER BY customer_full_name ASC
LIMIT 3 OFFSET 1;
-- 10
SELECT c.customer_id AS ma_khach_hang,
     c.customer_full_name AS ho_va_ten, 
    COUNT(b.booking_id) AS so_luong_phong
FROM customer c
JOIN booking b 
ON c.customer_id = b.customer_id
JOIN payment p 
ON b.booking_id = p.booking_id
GROUP BY c.customer_id,c.customer_full_name
HAVING COUNT(b.booking_id) >= 2 
AND SUM(p.payment_amount) > 1000;
-- 11
SELECT r.room_id AS ma_phong,r.room_type AS loai_phong,r.room_price AS gia_phong, 
    SUM(p.payment_amount) AS tong_tien_thanh_toan
FROM room r
JOIN booking b 
ON r.room_id = b.room_id
JOIN payment p ON b.booking_id = p.booking_id
GROUP BY r.room_id, r.room_type,r.room_price
HAVING 
    SUM(p.payment_amount) < 1000 
    AND COUNT(DISTINCT b.customer_id) >= 3;
-- 12
SELECT c.customer_id,c.customer_full_name, 
    b.room_id, SUM(p.payment_amount) AS tong_tien_thanh_toan
FROM customer c
JOIN booking b ON c.customer_id = b.customer_id
JOIN payment p ON b.booking_id = p.booking_id
GROUP BY c.customer_id, c.customer_full_name, b.room_id
HAVING SUM(p.payment_amount) > 1000;
-- 13
SELECT customer_id AS ma_khach_hang , customer_full_name AS ho_va_ten ,customer_email AS email,customer_phone AS phone
FROM customer
WHERE customer_full_name LIKE '%Minh%' 
    OR customer_address LIKE '%Hanoi%'
ORDER BY customer_full_name ASC;
-- 14
SELECT room_id AS ma_phong ,room_type AS loai_phong ,room_price AS gia_phong
FROM room
ORDER BY room_price DESC
LIMIT 5 OFFSET 5;
-- p3
-- 15
CREATE VIEW view_booking_before_10 AS
SELECT r.room_id,r.room_type, 
       c.customer_id,c.customer_full_name
FROM room r
JOIN booking b ON r.room_id = b.room_id
JOIN customer c ON b.customer_id = c.customer_id
WHERE b.check_in_date < '2025-03-10';
SELECT * FROM view_booking_before_10;
-- 16
CREATE VIEW view_rooms_area_min30 AS
SELECT c.customer_id,c.customer_full_name, 
       r.room_id,r.room_area
FROM customer c
JOIN booking b ON c.customer_id = b.customer_id
JOIN room r ON b.room_id = r.room_id
WHERE r.room_area > 30;
SELECT*FROM view_rooms_area_min30;
-- 17
DELIMITER $$
CREATE TRIGGER check_insert_booking
BEFORE INSERT ON booking
FOR EACH ROW
BEGIN
    IF NEW.check_in_date > NEW.check_out_date THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Lỗi!!!Ngày đặt phòng phải trước ngày trả phòng.';
    END IF;
END $$
DELIMITER ;
-- check: ng
INSERT INTO booking(customer_id, room_id, check_in_date, check_out_date, total_amount) 
VALUE ('C001', 'R001', '2025-03-05', '2025-03-01', 100);  -- hiện ra lỗi
-- check: ok
INSERT INTO booking(customer_id, room_id, check_in_date, check_out_date, total_amount) 
VALUE ('C001', 'R001', '2025-03-05', '2025-03-06', 100);  -- thành công
-- 18
DELIMITER $$
CREATE TRIGGER update_room_status_on_booking
AFTER INSERT ON booking
FOR EACH ROW
BEGIN
    UPDATE room 
    SET room_status = 'Booked'
    WHERE room_id = NEW.room_id;
END $$
DELIMITER ;
-- text 
SELECT*FROM room;
SELECT*FROM booking;
INSERT INTO booking(customer_id, room_id, check_in_date, check_out_date, total_amount) 
VALUE ('C001', 'R001', '2025-04-01', '2025-04-05', 400);

-- p5
-- 19
DELIMITER $$
CREATE PROCEDURE add_customer(
    IN in_customer_id VARCHAR(5),
    IN in_full_name VARCHAR(100),
    IN in_email VARCHAR(100),
    IN in_phone VARCHAR(15),
    IN in_address VARCHAR(255)
)
BEGIN
    INSERT INTO customer (customer_id,customer_full_name,customer_email,customer_phone,customer_address) 
    VALUE (in_customer_id,in_full_name,in_email,in_phone,in_address);
END $$
DELIMITER ;
-- check
CALL add_customer('C011', 'Pham Van L', 'l.pham@example.com', '0988776655', 'Ninh Binh, VietNam');
SELECT*FROM customer;
-- 20
DELIMITER $$
CREATE PROCEDURE add_payment(
IN p_booking_id INT,
IN p_payment_method VARCHAR(50),
IN p_payment_amount DECIMAL(10,2),
IN p_payment_date DATE
)
BEGIN
    INSERT INTO payment (booking_id,payment_method,payment_amount,payment_date) 
    VALUE (p_booking_id,p_payment_method,p_payment_amount,p_payment_date);
END $$
DELIMITER ;
-- check
CALL add_payment(1, 'Credit Card', 500.00, '2026-03-03');
SELECT*FROM payment;