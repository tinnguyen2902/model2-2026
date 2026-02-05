CREATE TABLE employees (
id int primary key not null,
full_name varchar(255) not null,
salary DOUBLE not null
);
INSERT INTO employees(id,full_name,salary) VALUE
('1','NGUYEN VN A','12000000'),
('2','NGUYEN VN A1','13000000'),
('3','NGUYEN VN A2','14000000'),
('4','NGUYEN VN A3','1000000');
SELECT*FROM employees;
DELIMITER $$
CREATE PROCEDURE sp_get_avg_salary()
BEGIN
DECLARE avg_salary DOUBLE;
-- gán thông qua select
SELECT AVG(salary) INTO avg_salary FROM employees;
SELECT avg_salary AS 'lương trung bình';
END $$
DELIMITER ;
CALL sp_get_avg_salary();