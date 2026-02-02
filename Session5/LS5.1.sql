CREATE TABLE students(
student_id VARCHAR(20) PRIMARY KEY NOT NULL,
full_name VARCHAR(100) NOT NULL,
birth_year DATE ,
gender VARCHAR(10) NOT NULL,
score DECIMAL(5,2) NOT NULL
);
INSERT INTO students (student_id,full_name,birth_year,gender,score)
VALUE ('001','Nguyen van a','2000-01-01','MALE','8.32'),
('002','Le van a','2003-12-01','FEMALE','5.22'),
('003','Pham van b','2008-01-21','MALE','6.62'),
('004','Nguyen Tran van t','2004-11-01','MALE','7.3'),
('005','Dinh van m','2002-01-01','MALE','7.36'),
('006','Hoang van a','1999-01-01','FEMALE','9.32'),
('007','Nguyen van at','2003-01-01','MALE','8.2'),
('008','Nguyen anh','2002-01-01','MALE','9.02');
SELECT*FROM students;
-- hiển thị mã sinh viên,họ và tên IN HOA TOÀN BỘ
SELECT student_id,
UPPER (full_name)
AS 'họ_va_ten'
FROM students;
-- hiển thị họ và tên, số tuổi
SELECT full_name AS 'Họ và tên',
TIMESTAMPDIFF(YEAR,birth_year,'2026-12-31') AS'Tuổi'
FROM students;
-- hiển thị điểm trung bình làm tròn 1 chữ số thập phân
SELECT full_name AS 'họ tên',
ROUND (score,1) AS 'điểm sau khi làm tròn'
FROM students;
-- hiển thị tổng số sinh viên, điểm cao nhất, điểm thấp nhất
SELECT COUNT(*) AS 'Tổng số sinh viên:',
MAX(score) AS 'số điểm cao nhất',
MIN(score) AS 'số điểm thấp nhất:'
FROM students;
