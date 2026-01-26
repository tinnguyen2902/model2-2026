CREATE TABLE Students(
Studen_ID VARCHAR(20) PRIMARY KEY NOT NULL,
Full_name VARCHAR(100) NOT NULL,
Birth_date DATE NOT NULL,
Gender ENUM ('NAM','NU'),
Email VARCHAR(20)
);
INSERT INTO Students(Studen_ID,Full_name, Birth_date, Gender, Email)
VALUES
('0001','NGUYEN LE A','2000-02-01','NAM','a＠gmail.com'),
('0002','LE VAN C','1999-02-04','NAM','c＠gmail.com'),
('0003','TRAN THI D','2005-09-01','NU', 'trang＠gmail.com'),
('0004','TRAN VAN D','2005-09-01','NAM', 'tran＠gmail.com'),
('0005','NGUYEN THI D','2005-09-01','NU','');
SELECT*FROM Students;
SELECT Studen_ID,Full_name,Email FROM Students;