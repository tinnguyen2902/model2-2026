CREATE TABLE employess(
emp_id varchar(20) NOT NULL,
full_name varchar(100) NOT NULL,
birth_year timestamp NOT NULL,
department Varchar(100) NOT NULL,
salary DECIMAL(20,2) NOT NULL,
phone varchar(12)
);
INSERT INTO employess (emp_id,full_name,birth_year,department,salary,phone)
VALUE ('IT0001','NGUYEN VAN TET','20030102','IT','10000000',''),
('SL0002','LE VAN TIET','20001212','SALE','12000000','010-002-0002'),
('HR0003','NGUYEN THI T','19990131','HR','7000000','090-000-002'),
('HR0004','NGUYEN VAN T','20050101','HR','12000000',''),
('SL0005','NGUYEN VAN VIET','19980123','SALE','15000000','090-000-1234'),
('IT0006','PHAM VAN TET M','20011213','IT','8000000','090-099-1211'),
('IT0007','NGUYEN LE VAN TET','20051223','IT','11000000',''),
('SL0008','TRAN VAN TET','20050123','SALE','8000000','090-111-222'),
('HR0009','NGUYEN THI TET','20021215','HR','6000000','090-234-211'),
('IT00010','NGUYEN LE VAN TIET','20031114','IT','12000000',''),
('SL00011','PHAM VAN TIENG','20040405','SALE','12000000','090-111-2224'),
('HR00012','NGUYEN VAN PHAN','19931203','HR','17000000',''),
('SL00013','NGUYEN LE VAN NAM','19931218','SL','20000000','');
-- danh sách NV có mức lương từ 10tr đến 20tr
SELECT*FROM employess
WHERE salary between '10000000' AND '20000000';
-- danh sách NV IT or HR
SELECT*FROM employess
WHERE department IN ('HR','IT');
-- hiển thị NV có họ tên chứ chữ ANH
SELECT*FROM employess
WHERE full_name LIKE '%ANH%';
-- Hiển thị NV chưa có sđt
SELECT*FROM employess
WHERE phone = '';
-- cập nhật lương tăng 10% cho IT
SET SQL_SAFE_UPDATES = 0;
UPDATE employess
SET salary = salary*1.1
WHERE department = 'IT';
-- cập nhật sđt cho nv chưa có sđt
-- thêm dòng dưới để mở rộng độ dài cột phone để không bị lỗi
ALTER TABLE employess MODIFY phone VARCHAR(20);
-- để đổi số điện thoại cho nhiều ID khác nhau chỉ trong một câu lệnh duy nhất thì dùng CASE WHEN:
UPDATE employess
SET phone = CASE
WHEN emp_id = 'IT0001' THEN '090-1111-555'
WHEN emp_id = 'HR0004' THEN '090-1112-555'
WHEN emp_id = 'IT0007' THEN '090-1113-555'
WHEN emp_id = 'IT00010' THEN '090-1115-555'
WHEN emp_id = 'HR00012' THEN '090-1112-655'
WHEN emp_id = 'SL00013' THEN '090-1112-6755'
ELSE phone
END
WHERE emp_id IN('IT0001','HR0004','IT0007','IT00010','HR00012','SL00013');
-- xóa nhân viên có mức lương dưới 10tr
DELETE FROM employess
WHERE salary < '10000000';