CREATE TABLE scores (
student_id VARCHAR(20)NOT NULL,
subject VARCHAR(100) NOT NULL,
score DECIMAL(5,3) NOT NULL
);
SELECT*FROM scores;
INSERT INTO scores (student_id,subject,score) VALUE
('SV01','TOÁN','8.25'),
('SV02','LY','5.6'),
('SV03','TIN','7.55'),
('SV01','LY','8.25'),
('SV02','SINH','5.6'),
('SV03','SU','7.55') ,
('SV01','TIN','8.25'),
('SV02','DIA','5.6'),
('SV03','TOAN','7.55');
-- tính điểm tb mỗi sv
SELECT student_id AS 'id sinh viên',AVG(score) AS 'điểm trung bình '
FROM scores
GROUP BY student_id;
-- hiển thị sv có đtb >= 7
SELECT student_id AS 'id sinh viên',AVG(score) AS 'điểm trung bình '
FROM scores
GROUP BY student_id
HAVING AVG(score)>=7;
-- hiển thị SV có điểm tb max
SELECT student_id AS 'id sinh viên',AVG(score) AS 'điểm trung bình cao nhất'
FROM scores
GROUP BY student_id
ORDER BY AVG(score) DESC
LIMIT 1;
-- hiển thị SV có điểm tb cao hơn so với tb chung
SELECT student_id AS 'id sinh viên',AVG(score) AS 'điểm trung bình cao nhất'
FROM scores
WHERE score >(SELECT AVG(score) FROM scores)
GROUP BY student_id;
