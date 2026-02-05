SELECT * FROM Lession8.students;
DELIMITER $$
CREATE PROCEDURE sp_classify_student (
IN in_gpa decimal(5,2),
OUT rangking VARCHAR(20)
)
BEGIN
DECLARE diem decimal(5,2);
SET diem = in_gpa;
SET rangking = CASE
  WHEN diem < 5.0 THEN 'Yếu'
  WHEN diem >=5 AND diem <6.5 THEN 'trung bình'
  WHEN diem >=6.5 AND diem <8 THEN 'khá'
  ELSE 'giỏi'
  END;
END $$
DELIMITER ;
SET @ranking = '';
CALL sp_classify_student(9.5,@ranking);
SELECT @ranking;