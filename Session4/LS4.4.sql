SELECT*FROM Students;
UPDATE Students 
SET Email=''
WHERE Studen_ID IN  ('0002', '0005');
SELECT*FROM Students;
-- hiển thị danh sách SV chưa có email.
SELECT*FROM Students
WHERE Email ='';
-- hiển thị danh sách SV có email.
SELECT*FROM Students
WHERE Email !='';
-- hiển thị danh sách SV có tên bắt đầu bằng Ng.
SELECT*FROM Students
WHERE Full_name LIKE 'NG%';
-- hiển thị không phải nam
SELECT*FROM Students
WHERE Gender != 'NAM';