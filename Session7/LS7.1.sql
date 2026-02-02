CREATE TABLE students (
svId VARCHAR(20) PRIMARY KEY NOT NULL,
svName VARCHAR(100) NOT NULL,
brithYear DATE ,
class VARCHAR(10) NOT NULL,
address VARCHAR(200) NOT NULL
);
INSERT INTO students(svId,svName,brithYear,class,address) VALUE
('SV001', 'Tran Thi B', '2001-01-02', 'CTK42', 'Hai Phong'),
('SV002', 'Le Van C', '2003-12-12', 'CTK44', 'Da Nang'),
('SV003', 'Pham Thi D', '2002-11-22', 'CTK43', 'Ho Chi Minh');
SELECT*FROM students;
-- tạo view:
CREATE VIEW v_student_basic AS
SELECT svId,svName,class
FROM students;
-- lệnh create view
SELECT*FROM v_student_basic;
