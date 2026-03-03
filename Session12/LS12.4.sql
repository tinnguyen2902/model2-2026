CREATE DATABASE employee_management;
USE employee_management;
-- 1. Bảng departments (Phòng ban)
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(255) NOT NULL
);

-- 2. Bảng employees (Nhân viên)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE
);

-- 3. Bảng attendance (Chấm công)
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    total_hours DECIMAL(5,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- 4. Bảng salaries (Bảng lương)
CREATE TABLE salaries (
    employee_id INT PRIMARY KEY,
    base_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- 5. Bảng salary_history (Lịch sử lương)
CREATE TABLE salary_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- Trigger BEFORE INSERT:
DELIMITER $$
CREATE TRIGGER before_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
  IF NEW.email NOT LIKE '%＠company.com' THEN
  -- gán lại giá trị bằng cách thêm đuôi
  SET NEW.email = CONCAT(NEW.email,'＠company.com');
  END IF;
END $$
DELIMITER ;
-- check
SELECT*FROM departments;
INSERT INTO employees (name, email, phone, hire_date, department_id)
VALUES ('Nguyen Van A', 'vana', '0912345678', '2024-05-20', 1);
SELECT*FROM employees; -- đã tự động thêm đuôi ＠ thành công

-- Trigger AFTER INSERT:
DELIMITER $$
CREATE TRIGGER after_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
  INSERT INTO salaries(employee_id,base_salary,bonus) VALUE
  (NEW.employee_id,10000000,0);
END $$
DELIMITER ; 
-- check
SELECT*FROM employees;
INSERT INTO employees (name,email,phone,hire_date,department_id) value
('Le van B','vanB','090-111-2222','2023-01-01',2);
SELECT*FROM salaries;   -- thêm thành công lương 10tr vs bonus = 0

-- Trigger BEFORE UPDATE:
DROP TRIGGER before_update;
DELIMITER $$
CREATE TRIGGER before_update
BEFORE UPDATE ON attendance
FOR EACH ROW
BEGIN
-- check out time có null hay không
 IF NEW.check_out_time IS NOT NULL THEN
   -- check out có trước check in hay không
  IF NEW.check_out_time <= NEW.check_in_time THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'lỗi !!! thời gian out phải sau in';
  END IF;  
  -- hợp lý tính total_time
  SET NEW.total_hours = TIMESTAMPDIFF(SECOND,NEW.check_in_time,NEW.check_out_time)/3600.0;  -- đơn vị giờ, làm tròn 2 chữ số second
  IF NEW.total_hours > 24 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'lỗi !!! thời gian làm việc không quá 24h';
  END IF;
  END IF;
END $$
DELIMITER ;
-- check
SELECT*FROM employees;
SELECT*FROM attendance;
UPDATE attendance 
SET check_out_time = '2024-05-20 07:00:00' 
WHERE attendance_id = 1;  -- hiện ra lỗi out phải sau in

-- 