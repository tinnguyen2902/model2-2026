USE Lession10 ;
CREATE TABLE employees (
id INT AUTO_INCREMENT primary key,
first_name VARCHAR(50) not null,
last_name VARCHAR(50) not null,
salary DECIMAL(10,2) not null,
email VARCHAR(100) UNIQUE,
phone_number VARCHAR(15)
);
SELECT*FROM employees;
CREATE TABLE salary_log (
log_id INT auto_increment primary key,
employee_id int not null,
FOREIGN KEY (employee_id)
REFERENCES employees(id),
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
change_date datetime default current_timestamp -- default curent_timestamp: tự động định dạng thời gian nhập vào
);
SELECT*FROM salary_log;
INSERT INTO employees (first_name,last_name,salary,email,phone_number) VALUES
('NGUYEN VAN','A1','8000000','abc@gmail.com','090-1234-7890'),
('NGUYEN VAN','A2','8100000','abc1@gmail.com','090-1234-7891'),
('NGUYEN VAN','A3','8200000','abc2@gmail.com','090-1234-7892'),
('NGUYEN VAN','A4','8300000','abc3@gmail.com','090-1234-7893'),
('NGUYEN VAN','A5','1800000','abc4@gmail.com','090-1234-7894'),
('NGUYEN VAN','A6','12000000','abc5@gmail.com','090-1234-7895'),
('NGUYEN VAN','A7','12000000','abc6@gmail.com','090-1234-7896'),
('NGUYEN VAN','A8','9000000','abc7@gmail.com','090-1234-7897'),
('NGUYEN VAN','A9','10000000','abc8@gmail.com','090-1234-7898'),
('NGUYEN VAN','Aa','11000000','abc9@gmail.com','090-1234-7899'),
('NGUYEN VAN','Ab','83000000','abc12@gmail.com','090-1234-78910'),
('NGUYEN VAN','Ac','81000000','abc21@gmail.com','090-1234-78920'),
('NGUYEN VAN','Ad','81000000','abc211@gmail.com','090-1234-78290');
DELIMITER $$
CREATE TRIGGER trg_after_update_salary 
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
  IF OLD.salary <> NEW.salary THEN
  INSERT INTO salary_log (employee_id,old_salary,new_salary,change_date) VALUE
  (OLD.id,OLD.salary,NEW.salary,current_timestamp);
  END IF;
END $$
DELIMITER ;

