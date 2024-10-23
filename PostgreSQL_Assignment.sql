-- Active: 1729147235427@@127.0.0.1@5432@university_db
CREATE DATABASE university_db;


-- Create the students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(20)
);


-- Create the courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL
);


-- Create the enrollment table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE
);

-- Insert data into the students table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
( 'Sameer', 21, 'sameer@example.com', 48, 60, NULL ),
( 'Zoya', 23, 'zoya@example.com', 52, 58, NULL ),
( 'Nabil', 22, 'nabil@example.com', 37, 46, NULL ),
( 'Rafi', 24, 'rafi@example.com', 41, 40, NULL ),
( 'Sophia', 22, 'sophia@example.com', 50, 52, NULL ),
( 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL );



-- Insert data into the courses table
INSERT INTO courses (course_name, credits) VALUES
( 'Next.js', 3 ),
( 'React.js', 4 ),
( 'Databases', 3 ),
( 'Prisma', 3 );



-- Insert data into the enrollment table
INSERT INTO enrollment (student_id, course_id) VALUES
(1, 1), (1, 2), (2, 1), (3, 2);



-- Insert a new student (replace with your details)
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Sabbir', 23, 'sabbirshnt@gmail.com', 80, 70, NULL);



-- Get student names enrolled in 'Next.js'
SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';




-- Update status to 'Awarded' for the student with the highest total marks
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

-- Delete courses without enrolled students
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM enrollment
);



-- Retrieve two student names starting from the 3rd student
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;



-- Retrieve course names with the count of enrolled students
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;



-- Calculate average age of all students
SELECT ROUND(AVG(age), 2) AS average_age
FROM students;



-- Get student names with 'example.com' in their email
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';






