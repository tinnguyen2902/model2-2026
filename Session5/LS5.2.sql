CREATE TABLE employees(
emp_idemp VARCHAR(20) PRIMARY KEY NOT NULL,
full_name VARCHAR(100) NOT NULL,
department VARCHAR(50) NOT NULL,
salary DECIMAL(10,0)
);
INSERT INTO employees (emp_id,full_name,department,salary)
VALUE (0001,'LE THI TT', 'HR','10000000'),
(0002,'LE VAN B', 'IT','12000000'),
(0003,'NGUYEN THI ABC', 'HR','15000000'),
(0004,'LE THI B', 'SALE','18000000'),
(0005,'TRAN THI TT', 'HR','8000000'),
(0006,'PHAM THI TT', 'HR','7000000'),
(0007,'HOANG THI TT', 'HR','14000000'),
(0008,'NAM THI TT', 'SALE','6000000'),
(0009,'QUACH THI TT', 'SALE','12000000'),
(00010,'LE THI TT', 'HR','10000000'),
(00011,'NGUYEN THI TT', 'SALE','19000000'),
(00012,'PHAN THI TT', 'IT','20000000'),
(00013,'LE THI TT', 'HR','20000000');
SELECT*FROM employees;
-- thống kê mỗi phòng ban có bao nhiêu người
SELECT department,
COUNT(*) AS 'số nhân viên'
FROM employees
GROUP BY department;
-- tính mức lương trung bình mỗi phòng ban
SELECT department,
ROUND(AVG(salary),0) AS 'lương trung bình mỗi phòng:' -- dùng round để làm tròn
FROM employees
GROUP BY department;
-- chỉ hiển thị các phòng có trên 3NV
SELECT department,
COUNT(*) AS'số phòng trên 3 NV:'
FROM employees
GROUP BY department
HAVING COUNT(*) >3;
-- chỉ hiển thị các phòng ban có lương trung bình lớn hơn 12tr
SELECT department,
ROUND(AVG(salary),0) AS 'Lương TB:'
FROM employees
GROUP BY department
HAVING AVG(salary)>12000000;

