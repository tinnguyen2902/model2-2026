SELECT*FROM employees;
ALTER TABLE employees ADD ID_number VARCHAR(20);
UPDATE employees
SET ID_number = '20001'
WHERE id = '1';
UPDATE employees
SET ID_number = '20002'
WHERE id = '2';
UPDATE employees
SET ID_number = '20003'
WHERE id = '3';
UPDATE employees
SET ID_number = '20004'
WHERE id = '4';
UPDATE employees
SET ID_number = '20005'
WHERE id = '5';
UPDATE employees
SET ID_number = '20006'
WHERE id = '6';
UPDATE employees
SET ID_number = '20007'
WHERE id = '7';
UPDATE employees
SET ID_number = '20008'
WHERE id = '8';
UPDATE employees
SET ID_number = '20009'
WHERE id = '9';
CREATE VIEW view_face AS 
SELECT id,full_name,department
FROM employees;
SELECT*FROM view_face;