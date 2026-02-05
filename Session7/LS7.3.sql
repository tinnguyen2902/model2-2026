USE Lession7;
CREATE TABLE employees (
id int primary key not null,
full_name varchar(255) not null,
department varchar(100) not null,
salary decimal(10,0) not null
);
INSERT INTO employees (id,full_name,department,salary)
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
CREATE INDEX idx_department 
ON employees(department);
