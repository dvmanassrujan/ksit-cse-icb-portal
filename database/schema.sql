-- CSE (ICB) Department Integrated Academic and Information Portal
-- K. S. Institute of Technology (KSIT), Bengaluru
-- Relational Database Schema (MySQL Compatible)

CREATE DATABASE IF NOT EXISTS `ksit_cse_icb` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `ksit_cse_icb`;

-- Disable foreign key checks for clean drop/re-creation
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `notifications`;
DROP TABLE IF EXISTS `community_activities`;
DROP TABLE IF EXISTS `placements`;
DROP TABLE IF EXISTS `library_resources`;
DROP TABLE IF EXISTS `events`;
DROP TABLE IF EXISTS `notices`;
DROP TABLE IF EXISTS `exam_marks`;
DROP TABLE IF EXISTS `examinations`;
DROP TABLE IF EXISTS `assignment_submissions`;
DROP TABLE IF EXISTS `assignments`;
DROP TABLE IF EXISTS `study_materials`;
DROP TABLE IF EXISTS `attendance`;
DROP TABLE IF EXISTS `timetable`;
DROP TABLE IF EXISTS `classes`;
DROP TABLE IF EXISTS `subjects`;
DROP TABLE IF EXISTS `teachers`;
DROP TABLE IF EXISTS `students`;
DROP TABLE IF EXISTS `survey_responses`;
DROP TABLE IF EXISTS `users`;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Users Table (Core Authentication)
CREATE TABLE `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `role` ENUM('student', 'teacher', 'department') NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `phone` VARCHAR(20),
  `avatar_url` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Students Profile Table
CREATE TABLE `students` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL UNIQUE,
  `usn` VARCHAR(20) NOT NULL UNIQUE,
  `year` VARCHAR(10) DEFAULT '1st Year',
  `semester` INT DEFAULT 1,
  `section` VARCHAR(5) DEFAULT 'A',
  `department` VARCHAR(50) DEFAULT 'CSE (ICB)',
  `cgpa` DECIMAL(3, 2) DEFAULT 8.12,
  `present_days` INT DEFAULT 46,
  `total_days` INT DEFAULT 50,
  `blood_group` VARCHAR(5) DEFAULT 'O+',
  `mentor_name` VARCHAR(100) DEFAULT 'Prof. R. Sharma',
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. Teachers Profile Table
CREATE TABLE `teachers` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL UNIQUE,
  `employee_id` VARCHAR(20) NOT NULL UNIQUE,
  `designation` VARCHAR(100) DEFAULT 'Assistant Professor',
  `department` VARCHAR(50) DEFAULT 'CSE (ICB)',
  `qualification` VARCHAR(100) DEFAULT 'M.Tech, Ph.D.',
  `cabin_no` VARCHAR(20) DEFAULT 'B-304',
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Subjects Table
CREATE TABLE `subjects` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `code` VARCHAR(20) NOT NULL UNIQUE,
  `name` VARCHAR(100) NOT NULL,
  `semester` INT NOT NULL,
  `credits` INT DEFAULT 4,
  `faculty_id` INT,
  `classes_conducted` INT DEFAULT 20,
  FOREIGN KEY (`faculty_id`) REFERENCES `teachers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 5. Timetable / Daily Schedule
CREATE TABLE `timetable` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `semester` INT NOT NULL,
  `day_of_week` ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') NOT NULL,
  `period_no` INT NOT NULL,
  `period_label` VARCHAR(20) DEFAULT 'Period 1',
  `time_slot` VARCHAR(30) NOT NULL,
  `subject_id` INT,
  `room_no` VARCHAR(20) DEFAULT 'B-Block',
  `is_break` BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 6. Attendance Table
CREATE TABLE `attendance` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `student_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `period_no` INT NOT NULL,
  `status` ENUM('present', 'absent', 'on_duty', 'leave') NOT NULL DEFAULT 'present',
  `marked_by` INT,
  `remarks` VARCHAR(100),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7. Academic Resource Hub (Study Materials, Syllabus, PYQs, Papers, Courses, Certs)
CREATE TABLE `study_materials` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT,
  `category` ENUM('notes', 'syllabus', 'pyq', 'research_paper', 'online_course', 'certification') NOT NULL,
  `subject_id` INT,
  `semester` INT NOT NULL,
  `file_url` VARCHAR(255),
  `external_url` VARCHAR(255),
  `file_size` VARCHAR(20) DEFAULT '2.4 MB',
  `file_type` VARCHAR(10) DEFAULT 'PDF',
  `uploaded_by` VARCHAR(100) DEFAULT 'Faculty',
  `downloads_count` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 8. Assignments Table
CREATE TABLE `assignments` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(200) NOT NULL,
  `subject_id` INT NOT NULL,
  `semester` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `description` TEXT NOT NULL,
  `created_date` DATE NOT NULL,
  `deadline` DATE NOT NULL,
  `max_marks` INT DEFAULT 20,
  `attachment_url` VARCHAR(255),
  FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`faculty_id`) REFERENCES `teachers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 9. Assignment Submissions Table
CREATE TABLE `assignment_submissions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `assignment_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `submission_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `submission_file` VARCHAR(255),
  `submission_text` TEXT,
  `status` ENUM('pending', 'submitted', 'evaluated') NOT NULL DEFAULT 'submitted',
  `marks_obtained` DECIMAL(4, 1),
  `feedback` TEXT,
  FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 10. Examinations Schedule Table
CREATE TABLE `examinations` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(150) NOT NULL,
  `exam_type` ENUM('internal_1', 'internal_2', 'semester_exam', 'makeup_exam') NOT NULL,
  `subject_id` INT NOT NULL,
  `semester` INT NOT NULL,
  `exam_date` DATE NOT NULL,
  `start_time` VARCHAR(10) NOT NULL,
  `end_time` VARCHAR(10) NOT NULL,
  `room_no` VARCHAR(20) DEFAULT 'B-Block',
  `max_marks` INT DEFAULT 50,
  `status` ENUM('scheduled', 'completed', 'postponed') DEFAULT 'scheduled',
  FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 11. Student Exam & Internal Marks
CREATE TABLE `exam_marks` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `student_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  `exam_type` VARCHAR(50) NOT NULL,
  `marks_obtained` DECIMAL(4, 1) NOT NULL,
  `max_marks` DECIMAL(4, 1) NOT NULL DEFAULT 50.0,
  `semester` INT NOT NULL,
  FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 12. Notices & Announcements Table
CREATE TABLE `notices` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NOT NULL,
  `category` ENUM('Exams', 'General', 'CBP', 'Hostel', 'Placement', 'Faculty') NOT NULL DEFAULT 'General',
  `priority` ENUM('normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
  `is_new` BOOLEAN DEFAULT TRUE,
  `target_role` ENUM('all', 'student', 'teacher', 'department') DEFAULT 'all',
  `date_posted` DATE NOT NULL,
  `author_name` VARCHAR(100) DEFAULT 'HOD - CSE (ICB)'
) ENGINE=InnoDB;

-- 13. Events & Activities Table
CREATE TABLE `events` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(150) NOT NULL,
  `category` VARCHAR(50) DEFAULT 'Workshop',
  `event_date` DATE NOT NULL,
  `time_range` VARCHAR(50) NOT NULL,
  `venue` VARCHAR(100) NOT NULL,
  `organizer` VARCHAR(100) DEFAULT 'CSE (ICB) Dept',
  `description` TEXT,
  `registered_count` INT DEFAULT 0
) ENGINE=InnoDB;

-- 14. Library & Digital Resources
CREATE TABLE `library_resources` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(200) NOT NULL,
  `author` VARCHAR(150) NOT NULL,
  `isbn` VARCHAR(30),
  `category` VARCHAR(50) DEFAULT 'Computer Science',
  `semester` INT DEFAULT 1,
  `available_copies` INT DEFAULT 5,
  `rack_no` VARCHAR(20) DEFAULT 'Rack CS-04',
  `digital_access_url` VARCHAR(255)
) ENGINE=InnoDB;

-- 15. Placements & Career Training
CREATE TABLE `placements` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `company_name` VARCHAR(100) NOT NULL,
  `job_title` VARCHAR(100) NOT NULL,
  `role_type` ENUM('Full-time', 'Internship', 'Training') NOT NULL,
  `package_details` VARCHAR(50) NOT NULL,
  `eligibility` VARCHAR(100) DEFAULT 'CSE / ISE min 7.0 CGPA',
  `deadline` DATE NOT NULL,
  `apply_link` VARCHAR(255)
) ENGINE=InnoDB;

-- 16. Community-Based Project Activities
CREATE TABLE `community_activities` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `project_title` VARCHAR(255) NOT NULL,
  `team_name` VARCHAR(50) NOT NULL,
  `team_members` TEXT NOT NULL,
  `mentor` VARCHAR(100) NOT NULL,
  `status` ENUM('In Progress', 'Phase 1 Complete', 'Completed') DEFAULT 'In Progress',
  `objective` TEXT NOT NULL,
  `presentation_date` DATE DEFAULT '2026-09-29'
) ENGINE=InnoDB;

-- 17. Survey Findings & Real Data (Survey Conducted 26/09/2026, N=56)
CREATE TABLE `survey_responses` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `question_number` VARCHAR(10) NOT NULL,
  `question_text` VARCHAR(255) NOT NULL,
  `category` ENUM('challenges', 'usefulness', 'priority') NOT NULL,
  `student_count` INT NOT NULL,
  `total_surveyed` INT NOT NULL DEFAULT 56,
  `percentage` DECIMAL(5, 2) NOT NULL
) ENGINE=InnoDB;

-- 18. Notifications Table
CREATE TABLE `notifications` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `message` TEXT NOT NULL,
  `type` VARCHAR(30) DEFAULT 'system',
  `is_read` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;
