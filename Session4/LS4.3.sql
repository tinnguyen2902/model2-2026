SELECT*FROM Students;
INSERT INTO Students(Studen_ID,Full_name, Birth_date, Gender, Email)
VALUES
('0003','TRAN THI D','2005-09-01','NU', 'trang＠gmail.com');
-- hiển thị SV có năm sinh từ 2003 đến 2005
SELECT*FROM Students
WHERE Birth_date BETWEEN '2003-01-01' AND '2025-12-31';
-- Hiển thị giới tính nam
SELECT*FROM Students
WHERE Gender = 'NAM';
-- Hiển thị giới tính nữ
SELECT*FROM Students
WHERE Gender = 'NU';
-- Hiển thị SV có mã 0001, 0004,0005
SELECT*FROM Students
WHERE Studen_ID IN ('0001','0004','0005');
-- Hiển thị giới hạn cột
SELECT Studen_ID,Full_name,Birth_date
FROM Students;