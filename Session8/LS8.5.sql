CREATE TABLE employees85 (
id int primary key not null,
full_name varchar(255) not null,
salary double not null,
department varchar(20) not null
);
INSERT INTO employees85(id,full_name,salary,department) values
('1','NGUYEN VAN A','7000000','HR'),
('2','NGUYEN VAN A1','17000000','IT'),
('3','NGUYEN VAN A2','12000000','SALE'),
('4','NGUYEN VAN A3','14000000','HR'),
('5','NGUYEN VAN A4','20000000','IT');
DELIMITER $$
CREATE PROCEDURE sp_check_employee_income (
IN staff_name varchar(255),
IN staff_salary double)
BEGIN
    IF staff_salary < 8000000 THEN
      SELECT 'thu nhập thấp' AS 'đánh giá',
             full_name AS 'tên nhân viên',
             department AS 'phòng'
      FROM employees85
      WHERE full_name = staff_name;
 ELSEIF staff_salary >=8000000 AND staff_salary <15000000 THEN
       SELECT 'thu nhập trung bình'AS 'đánh giá',
              full_name AS'tên nhân viên',
              department AS 'phòng'
       FROM employees85
       WHERE full_name = staff_name;
 ELSE
       SELECT 'thu nhập cao' AS 'đánh giá',
             full_name AS'tên nhân viên',
             department AS 'phòng'
       FROM employees85
       WHERE full_name = staff_name;
END IF;
END $$
DELIMITER ;
CALL sp_check_employee_income('NGUYEN VAN A1',20000000);