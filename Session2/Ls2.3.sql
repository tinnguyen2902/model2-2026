USE Lession21 ;
CREATE TABLE Students_constraint (
ProductID VARCHAR(10),
FullName VARCHAR(30) NOT NULL,
Email VARCHAR(100) UNIQUE,
Age INT,
PRIMARY KEY (ProductID),
CONSTRAINT checkAge CHECK (age >= 18)
);