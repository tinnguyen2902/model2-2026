CREATE TABLE students (
id int primary key not null,
full_name varchar(255) not null,
class varchar(20) not null
);
INSERT INTO students(id,full_name,class) VALUE
('1','NGUYEN VAN A','12A'),
('2','NGUYEN LE A','12A'),
('3','NGUYEN VAN A1','12A2'),
('4','NGUYEN VAN A2','12A1');
SELECT*FROM students;
DELIMITER $$
CREATE PROCEDURE sp_get_all_students()
BEGIN
SELECT*FROM students;
END$$
DELIMITER ;
CALL sp_get_all_students;