CREATE DATABASE AlaskenaDb; 
USE AlaskenaDb;

-- Users Table (Login System)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('pupil', 'teacher', 'admin') NOT NULL
);

-- Pupils Table
CREATE TABLE Pupils (
    adm_no INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    address TEXT,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    admission_date DATE NOT NULL,
    grade_level ENUM('Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7', 'Grade 8') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Teachers Table
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    subject VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Subjects Table (For Primary School)
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name ENUM('Mathematics', 'English', 'Science', 'Social Studies', 'Physical Education', 'Music', 'Art', 'Computer Science') NOT NULL,
    teacher_id INT,
    credits INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id) ON DELETE SET NULL
);

-- Enrollments Table (For Primary School)
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    adm_no INT,
    subject_id INT,
    grade_level ENUM('Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7', 'Grade 8') NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (adm_no) REFERENCES Pupils(adm_no) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

-- Attendance Table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    adm_no INT,
    subject_id INT,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (adm_no) REFERENCES Pupils(adm_no) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

-- Exams & Results Table
CREATE TABLE Exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT,
    exam_date DATE NOT NULL,
    total_marks INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) ON DELETE CASCADE
);

CREATE TABLE Results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    adm_no INT,
    exam_id INT,
    marks_obtained INT,
    FOREIGN KEY (adm_no) REFERENCES Pupils(adm_no) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id) ON DELETE CASCADE
);

-- Fees Table
CREATE TABLE Fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    adm_no INT,
    amount DECIMAL(10,2) NOT NULL,
    due_date DATE,
    status ENUM('Paid', 'Pending', 'Overdue') NOT NULL,
    FOREIGN KEY (adm_no) REFERENCES Pupils(adm_no) ON DELETE CASCADE
);

-- News Table
CREATE TABLE News (
    news_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    date_posted TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Library Table
CREATE TABLE Library (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    available_copies INT DEFAULT 1
);
