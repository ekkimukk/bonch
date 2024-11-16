INSERT INTO students (name, d_id)
VALUES ('Alex', 10),
       ('Maria', 20),
       ('Peter', 30),
       ('Anna', 40),
       ('Max', 50);

SELECT * FROM students;
UPDATE students SET name = 'Ivan' WHERE id = 2;
SELECT * FROM students WHERE id = 2;
DELETE FROM students WHERE id = 2;
SELECT * FROM students;
