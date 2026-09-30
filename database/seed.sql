-- CSE (ICB) Department Integrated Academic and Information Portal
-- K. S. Institute of Technology (KSIT), Bengaluru
-- Seed Data Initialization

USE `ksit_cse_icb`;

-- 1. Users
INSERT INTO `users` (`id`, `username`, `password_hash`, `role`, `name`, `email`, `phone`, `avatar_url`) VALUES
(1, 'hussain', 'password123', 'student', 'Hussain Basha', 'hussain.basha@ksit.edu.in', '+91 98450 11223', '/assets/avatars/student1.png'),
(2, 'manas', 'password123', 'student', 'D V Manas Srujan', 'manas.srujan@ksit.edu.in', '+91 98450 22334', '/assets/avatars/student2.png'),
(3, 'pavani', 'password123', 'student', 'M Pavani Gowda', 'pavani.gowda@ksit.edu.in', '+91 98450 33445', '/assets/avatars/student3.png'),
(4, 'purvi', 'password123', 'student', 'Purvi B V', 'purvi.bv@ksit.edu.in', '+91 98450 44556', '/assets/avatars/student4.png'),
(5, 'prof_sharma', 'password123', 'teacher', 'Prof. R. Sharma', 'r.sharma@ksit.edu.in', '+91 98450 55667', '/assets/avatars/teacher1.png'),
(6, 'dr_ramesh', 'password123', 'teacher', 'Dr. S. Ramesh', 's.ramesh@ksit.edu.in', '+91 98450 66778', '/assets/avatars/teacher2.png'),
(7, 'prof_khan', 'password123', 'teacher', 'Prof. A. Khan', 'a.khan@ksit.edu.in', '+91 98450 77889', '/assets/avatars/teacher3.png'),
(8, 'dr_kumar', 'password123', 'department', 'Dr. R. Kumar', 'hod.cse@ksit.edu.in', '+91 98450 88990', '/assets/avatars/hod.png');

-- 2. Students
INSERT INTO `students` (`id`, `user_id`, `usn`, `year`, `semester`, `section`, `department`, `cgpa`, `present_days`, `total_days`, `blood_group`, `mentor_name`) VALUES
(1, 1, '1KS25IC023', '1st Year', 1, 'A', 'CSE (ICB)', 8.12, 46, 50, 'O+', 'Prof. R. Sharma'),
(2, 2, '1KS25IC015', '1st Year', 1, 'A', 'CSE (ICB)', 8.45, 48, 50, 'B+', 'Prof. R. Sharma'),
(3, 3, '1KS25IC033', '1st Year', 1, 'A', 'CSE (ICB)', 8.30, 47, 50, 'A+', 'Prof. R. Sharma'),
(4, 4, '1KS25IC045', '1st Year', 1, 'A', 'CSE (ICB)', 8.60, 49, 50, 'AB+', 'Prof. R. Sharma');

-- 3. Teachers
INSERT INTO `teachers` (`id`, `user_id`, `employee_id`, `designation`, `department`, `qualification`, `cabin_no`) VALUES
(1, 5, 'KSIT-FAC-014', 'Assistant Professor', 'CSE (ICB)', 'M.Tech (CSE), Ph.D.', 'B-304'),
(2, 6, 'KSIT-FAC-008', 'Associate Professor', 'Mathematics', 'M.Sc., Ph.D.', 'A-201'),
(3, 7, 'KSIT-FAC-019', 'Assistant Professor', 'Physics', 'M.Sc., M.Phil.', 'A-205');

-- 4. Subjects
INSERT INTO `subjects` (`id`, `code`, `name`, `semester`, `credits`, `faculty_id`, `classes_conducted`) VALUES
(1, 'MAT101', 'Mathematics', 1, 4, 2, 20),
(2, 'PHY102', 'Physics', 1, 4, 3, 20),
(3, 'CSE103', 'Programming in C', 1, 4, 1, 20),
(4, 'ENG104', 'Engineering Graphics', 1, 3, 1, 20),
(5, 'CSE301', 'Data Structures & Algorithms', 3, 4, 1, 22),
(6, 'CSE302', 'DBMS', 3, 4, 1, 22),
(7, 'CSE401', 'Cybersecurity', 7, 3, 1, 18);

-- 5. Timetable (Monday schedule matching screenshot)
INSERT INTO `timetable` (`semester`, `day_of_week`, `period_no`, `period_label`, `time_slot`, `subject_id`, `room_no`, `is_break`) VALUES
(1, 'Monday', 1, 'Period 1', '08:30 - 09:25 AM', 1, 'B-Block', FALSE),
(1, 'Monday', 2, 'Period 2', '09:25 - 10:20 AM', 2, 'B-Block', FALSE),
(1, 'Monday', 0, 'Tea Break', '10:20 - 10:35 AM', NULL, 'Campus Canteen', TRUE),
(1, 'Monday', 3, 'Period 3', '10:35 - 11:30 AM', 3, 'B-Block', FALSE),
(1, 'Monday', 4, 'Period 4', '11:30 - 12:25 PM', 4, 'B-Block', FALSE);

-- 6. Attendance Summary & Details
INSERT INTO `attendance` (`student_id`, `subject_id`, `date`, `period_no`, `status`, `marked_by`, `remarks`) VALUES
(1, 1, '2025-09-29', 1, 'present', 2, 'Regular'),
(1, 2, '2025-09-29', 2, 'present', 3, 'Active'),
(1, 3, '2025-09-29', 3, 'present', 1, 'Lab exercise completed'),
(1, 4, '2025-09-29', 4, 'present', 1, 'Drafting completed'),
(1, 1, '2025-09-26', 1, 'present', 2, 'Regular'),
(1, 2, '2025-09-26', 2, 'absent', 3, 'Medical slip provided'),
(1, 3, '2025-09-26', 3, 'present', 1, 'Regular'),
(1, 4, '2025-09-26', 4, 'present', 1, 'Regular');

-- 7. Academic Resource Hub (Study materials, Notes, Syllabus, PYQ, Research, Courses, Certs)
INSERT INTO `study_materials` (`id`, `title`, `description`, `category`, `subject_id`, `semester`, `file_url`, `external_url`, `file_size`, `file_type`, `uploaded_by`, `downloads_count`) VALUES
(1, 'Engineering Mathematics - Module 1 Calculus & Differential Equations', 'Comprehensive lecture notes and solved example problems for First Year VTU / KSIT syllabus.', 'notes', 1, 1, '/resources/maths_mod1_notes.pdf', NULL, '4.2 MB', 'PDF', 'Dr. S. Ramesh', 128),
(2, 'Programming in C - Complete Lecture Slides & Code Templates', 'Detailed presentation on pointers, memory allocation, arrays, structs, and recursion.', 'notes', 3, 1, '/resources/c_programming_slides.pdf', NULL, '3.8 MB', 'PDF', 'Prof. R. Sharma', 194),
(3, 'Applied Engineering Physics - Wave Optics & Lasers Unit Notes', 'Complete theory, derivation charts, and viva-voce questions for unit 2.', 'notes', 2, 1, '/resources/physics_unit2_notes.pdf', NULL, '2.9 MB', 'PDF', 'Prof. A. Khan', 88),
(4, 'CSE (ICB) 2025-26 Scheme & Detailed Syllabus Curriculum', 'Complete autonomous & VTU aligned curriculum structure for all 8 semesters of CSE (ICB).', 'syllabus', 3, 1, '/resources/cse_icb_syllabus_2025.pdf', NULL, '1.5 MB', 'PDF', 'HOD - CSE (ICB)', 312),
(5, 'VTU Semester End Exam Previous-Year Question Papers (2021-2024)', 'Bundled question papers with solution keys for First Year Mathematics, Physics & C Programming.', 'pyq', 1, 1, '/resources/pyq_bundle_sem1.pdf', NULL, '8.6 MB', 'PDF', 'Prof. R. Sharma', 246),
(6, 'Research Paper: Modern Optimization in Federated Deep Learning Systems', 'IEEE curated research survey paper recommended for second & third year student seminars.', 'research_paper', 3, 1, '/resources/federated_dl_survey.pdf', 'https://ieeexplore.ieee.org', '1.2 MB', 'PDF', 'Prof. R. Sharma', 54),
(7, 'NPTEL: Problem Solving through Programming in C (IIT Kharagpur)', 'Free 12-week NPTEL course with video modules and assignments for credit certification.', 'online_course', 3, 1, NULL, 'https://nptel.ac.in/courses/106105171', 'Online', 'LINK', 'Prof. R. Sharma', 142),
(8, 'AWS Certified Cloud Practitioner - Department Student Study Track', 'Self-paced training and discount voucher roadmap for CSE (ICB) students.', 'certification', 3, 1, NULL, 'https://aws.amazon.com/certification/certified-cloud-practitioner/', 'Online', 'LINK', 'HOD - CSE (ICB)', 115);

-- 8. Assignments
INSERT INTO `assignments` (`id`, `title`, `subject_id`, `semester`, `faculty_id`, `description`, `created_date`, `deadline`, `max_marks`, `attachment_url`) VALUES
(1, 'Assignment 1: Pointer Manipulation & Dynamic Memory in C', 3, 1, 1, 'Implement dynamic array resizing and string manipulation functions without library string functions.', '2025-09-20', '2025-10-04', 20, '/assignments/c_assignment_1.pdf'),
(2, 'Internal Assignment: Differential Equations & Applications', 1, 1, 2, 'Solve 10 assigned problems on first-order and second-order linear differential equations.', '2025-09-22', '2025-10-06', 20, '/assignments/maths_assignment_1.pdf'),
(3, 'Physics Unit 2: Optical Fiber Numerical Aperture Report', 2, 1, 3, 'Write a 4-page experimental summary calculating fractional index change and acceptance angle.', '2025-09-25', '2025-10-08', 15, '/assignments/physics_lab_report.pdf');

-- 9. Assignment Submissions
INSERT INTO `assignment_submissions` (`assignment_id`, `student_id`, `submission_date`, `submission_file`, `submission_text`, `status`, `marks_obtained`, `feedback`) VALUES
(1, 1, '2025-09-27 15:30:00', '/submissions/hussain_assignment1.c', 'Implemented dynamic memory allocation with malloc and free error handling.', 'submitted', NULL, 'Under review by Prof. Sharma'),
(2, 1, NULL, NULL, NULL, 'pending', NULL, 'Pending submission before deadline'),
(3, 1, NULL, NULL, NULL, 'pending', NULL, 'Pending submission before deadline');

-- 10. Examinations
INSERT INTO `examinations` (`id`, `title`, `exam_type`, `subject_id`, `semester`, `exam_date`, `start_time`, `end_time`, `room_no`, `max_marks`, `status`) VALUES
(1, 'Internal Test 1: Mathematics', 'internal_1', 1, 1, '2025-10-02', '10:00 AM', '12:00 PM', 'B-Block Room 204', 50, 'scheduled'),
(2, 'Internal Test 1: Physics', 'internal_1', 2, 1, '2025-10-05', '09:00 AM', '11:00 AM', 'B-Block Room 204', 50, 'scheduled'),
(3, 'Maths Makeup Exam', 'makeup_exam', 1, 1, '2025-10-12', '09:30 AM', '11:30 AM', 'B-Block Room 201', 50, 'scheduled');

-- 11. Exam Marks
INSERT INTO `exam_marks` (`student_id`, `subject_id`, `exam_type`, `marks_obtained`, `max_marks`, `semester`) VALUES
(1, 1, 'Unit Test 1', 44.0, 50.0, 1),
(1, 2, 'Unit Test 1', 41.5, 50.0, 1),
(1, 3, 'Unit Test 1', 46.0, 50.0, 1),
(1, 4, 'Unit Test 1', 42.0, 50.0, 1);

-- 12. Notices & Announcements (Matches screenshot)
INSERT INTO `notices` (`id`, `title`, `description`, `category`, `priority`, `is_new`, `target_role`, `date_posted`, `author_name`) VALUES
(1, 'Class Test Schedule - 1st Year CSE (ICB)', 'Internal Assessment Test 1 will commence from 2nd October 2025. Students are requested to check the hall allotment.', 'Exams', 'high', TRUE, 'student', '2025-09-28', 'HOD - CSE (ICB)'),
(2, 'Library timings extended till 5 PM', 'The central and department library reading halls will remain open until 5:00 PM on all working weekdays.', 'General', 'normal', FALSE, 'all', '2025-09-27', 'Librarian'),
(3, 'Community Project Guidelines (AY 2025-26)', 'All first-year CSE (ICB) student teams must submit their problem statement and survey analysis report by 10th October.', 'CBP', 'high', FALSE, 'student', '2025-09-26', 'CBP Coordinator'),
(4, 'Hostel Mess Menu - This Week', 'Updated vegetarian and non-vegetarian catering schedule for the boys and girls hostel mess has been released.', 'Hostel', 'normal', FALSE, 'student', '2025-09-25', 'Hostel Warden'),
(5, 'Placement Training Session - Register Now', 'Campus Placement Cell announces pre-placement aptitude and technical interview prep sessions starting Saturday.', 'Placement', 'normal', FALSE, 'all', '2025-09-24', 'Placement Officer'),
(6, 'Department Meeting', 'All faculty members are requested to attend the monthly academic progress and NAAC documentation meeting.', 'Faculty', 'high', TRUE, 'teacher', '2025-09-28', 'Dr. R. Kumar, HOD');

-- 13. Events & Activities (Matches screenshot)
INSERT INTO `events` (`id`, `title`, `category`, `event_date`, `time_range`, `venue`, `organizer`, `description`, `registered_count`) VALUES
(1, 'Technical Talk - AI & ML', 'Seminar', '2025-10-02', '10:00 AM - 12:00 PM', 'Seminar Hall', 'CSE (ICB) Dept', 'Industry keynote on Generative AI architectures and practical machine learning deployment.', 94),
(2, 'Coding Contest', 'Hackathon', '2025-10-05', '09:00 AM - 01:00 PM', 'Lab 3', 'Coding Club', 'Speed programming round covering data structures and dynamic programming algorithmic challenges.', 78),
(3, 'Maths Makeup Exam', 'Exam', '2025-10-12', '09:30 AM - 11:30 AM', 'B-Block', 'Academic Cell', 'Special makeup examination for eligible students with medical clearance.', 16),
(4, 'Workshop - Full Stack Development', 'Workshop', '2025-10-12', '10:00 AM - 04:00 PM', 'Lab 1', 'STACK X & CSE ICB', 'Hands-on practical workshop covering Node.js, Express, MySQL and modern frontends.', 60);

-- 14. Library Resources
INSERT INTO `library_resources` (`title`, `author`, `isbn`, `category`, `semester`, `available_copies`, `rack_no`, `digital_access_url`) VALUES
('Higher Engineering Mathematics', 'B.S. Grewal', '978-8174091955', 'Mathematics', 1, 8, 'Rack M-02', 'https://library.ksit.edu.in/books/grewal'),
('Programming in ANSI C', 'E. Balagurusamy', '978-9353165130', 'Computer Science', 1, 12, 'Rack CS-01', 'https://library.ksit.edu.in/books/ansi-c'),
('Engineering Physics', 'Hitendra K. Malik', '978-0070671539', 'Physics', 1, 6, 'Rack P-04', 'https://library.ksit.edu.in/books/eng-physics');

-- 15. Placements
INSERT INTO `placements` (`company_name`, `job_title`, `role_type`, `package_details`, `eligibility`, `deadline`, `apply_link`) VALUES
('Infosys Springboard', 'Graduate Trainee / Systems Engineer', 'Full-time', '6.5 - 9.0 LPA', 'Min 7.0 CGPA, No Active Backlogs', '2025-10-30', 'https://careers.infosys.com'),
('TCS iON NQT', 'Associate Software Engineer', 'Full-time', '7.0 - 11.5 LPA', 'All CSE (ICB) Students', '2025-11-15', 'https://learning.tcsionhub.in'),
('Google Cloud Student Innovators', 'Cloud Engineer Intern', 'Internship', 'Stipend ₹35,000/mo', '1st & 2nd Year Students', '2025-10-20', 'https://buildyourfuture.withgoogle.com');

-- 16. Community Project Details (From PPTX)
INSERT INTO `community_activities` (`id`, `project_title`, `team_name`, `team_members`, `mentor`, `status`, `objective`, `presentation_date`) VALUES
(1, 'CSE (ICB) Department Integrated Academic and Information Portal', 'STACK X', 'D V Manas Srujan (1KS25IC015), Hussain Basha (1KS25IC023), M Pavani Gowda (1KS25IC033), Purvi B V (1KS25IC045)', 'Prof. R. Sharma & Dr. R. Kumar', 'In Progress', 'Centralize all scattered academic materials, attendance tracking, syllabus, PYQ, and announcements into a single unified department portal.', '2026-09-29');

-- 17. Survey Findings (Slide 6, 7, 8 - N=56 students on 26/09/2026)
INSERT INTO `survey_responses` (`question_number`, `question_text`, `category`, `student_count`, `total_surveyed`, `percentage`) VALUES
('Q1', 'Difficulty finding old study materials in WhatsApp groups', 'challenges', 51, 56, 91.07),
('Q2', 'Important announcements getting buried in group conversations', 'challenges', 49, 56, 87.50),
('Q3', 'Difficulty tracking subject-wise attendance in real time', 'challenges', 44, 56, 78.57),
('Q4', 'Lack of centralized previous-year question papers & syllabus', 'challenges', 46, 56, 82.14),
('Q5', 'Centralized study materials & PDF repository', 'usefulness', 53, 56, 94.64),
('Q6', 'Subject-wise attendance tracking feature', 'usefulness', 48, 56, 85.71),
('Q7', 'Assignment & deadline management system', 'usefulness', 47, 56, 83.93),
('Q8', 'Course & certification links hub', 'usefulness', 45, 56, 80.36),
('Q9_1', 'Study Materials (Most Wanted Feature)', 'priority', 48, 56, 85.70),
('Q9_2', 'Attendance Tracking', 'priority', 41, 56, 73.20),
('Q9_3', 'Previous-Year Question Papers', 'priority', 31, 56, 55.40),
('Q9_4', 'Activities and Events Calendar', 'priority', 31, 56, 55.40),
('Q9_5', 'Online Courses & Certifications', 'priority', 31, 56, 55.40);

-- 18. Notifications
INSERT INTO `notifications` (`user_id`, `title`, `message`, `type`, `is_read`) VALUES
(1, 'Assignment 1 Released', 'Prof. R. Sharma posted Assignment 1 for Programming in C due on Oct 04.', 'assignment', FALSE),
(2, 'Class Test Announced', 'Internal Test 1 timetable published for First Year CSE (ICB).', 'exam', FALSE),
(1, 'New Study Material', 'Dr. S. Ramesh uploaded Module 1 Calculus Notes to the Academic Hub.', 'resource', FALSE);
