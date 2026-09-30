# COMMUNITY-BASED PROJECT (CBP) REPORT

## CSE (ICB) Department Integrated Academic and Information Portal
**K. S. Institute of Technology (KSIT), Bengaluru**  
**Department of Computer Science & Engineering – ICB**  
**Academic Year:** 2025 – 2026  
**Team Name:** STACK X  

### Project Team Members
1. **D V Manas Srujan** — USN: `1KS25IC015`
2. **Hussain Basha** — USN: `1KS25IC023`
3. **M Pavani Gowda** — USN: `1KS25IC033`
4. **Purvi B V** — USN: `1KS25IC045`

### Project Mentors
* **Prof. R. Sharma** (Assistant Professor, Dept. of CSE – ICB, KSIT)
* **Dr. R. Kumar** (Head of Department, Dept. of CSE – ICB, KSIT)

---

## 1. Introduction
The **Department of Computer Science & Engineering – ICB (IoT, Cybersecurity with Blockchain)** at K. S. Institute of Technology (KSIT), Bengaluru, requires streamlined academic operations to support students, faculty, and administration. In today's digital era, rapid communication and instant access to accurate educational resources are vital for academic excellence. 

This Community-Based Project (CBP) conceptualizes, designs, and builds the **CSE (ICB) Department Integrated Academic and Information Portal**. Built around the core vision:
> **"One Platform. One Department. Better Academic Management."**

The platform creates three distinct role-based experiences:
* **Students:** Access • Track • Learn
* **Teachers:** Share • Manage • Evaluate
* **Department:** Organize • Communicate • Monitor

---

## 2. Problem Statement
Academic information in undergraduate engineering departments is currently highly fragmented. Communication and document sharing rely primarily on informal channels such as WhatsApp groups, Telegram channels, disparate email threads, and loose paper circulars.

### Specific Challenges:
1. **Scattered Information:** Academic notices, timetable changes, and examination circulars get buried under hundreds of informal peer chat messages in WhatsApp groups.
2. **Lost Notes & Study Materials:** Course lecture slides, handwritten notes, laboratory manuals, and PDFs shared months prior are near impossible to locate when students prepare for examinations.
3. **Missing Previous-Year Question Papers (PYQ):** VTU and autonomous scheme model question papers and solutions are scattered across private drives and student forums.
4. **Lack of Real-Time Attendance Tracking:** Students cannot track their subject-wise attendance percentages until periodic attendance registers are pinned to notice boards, leading to last-minute shortages (<75%) and exam hall ticket rejections.
5. **Assignment and Evaluation Bottlenecks:** Assignment deadlines and submissions lack a centralized dashboard, resulting in missed deadlines and manual tracking headaches for faculty members.
6. **Decentralized Career & Certification Links:** Emerging links for certifications (AWS, NPTEL, Coursera) and recruitment drives are shared haphazardly without structured archives.

---

## 3. Real-World Experience
As first-year engineering students in the Department of Computer Science & Engineering – ICB at KSIT, the team experienced these difficulties directly:
* Searching through weeks of WhatsApp chat history during midnight exam revision to find a single calculus formula sheet.
* Missing critical scholarship and internal assessment notices due to conversational clutter in class groups.
* Inability to verify whether attendance was marked correctly following an approved medical leave.

These firsthand experiences motivated the team to develop a centralized digital alternative tailored to the department's exact needs.

---

## 4. Student Community Survey
To validate these problems empirically rather than relying solely on anecdotal evidence, the team formulated and conducted a rigorous **Google Forms student community survey** on **26/09/2026** targeting first-year engineering and CSE (ICB) students.

### Survey Demographics
* **Date Conducted:** 26 September 2026
* **Target Audience:** First-Year Engineering / CSE (ICB) Students, KSIT
* **Total Valid Responses ($N$):** 56 Students
* **Survey Sections:**
  1. $Q_1 – Q_4$: Student Experience & Current Challenges
  2. $Q_5 – Q_8$: Feature Usefulness Evaluation
  3. $Q_9$: Feature Priority Ranking

---

## 5. Survey Results & Authentic Data Analysis
*(As documented in Project Presentation Slides 6, 7 & 8)*

### A. Current Challenges ($Q_1 – Q_4$)
| Question Code | Real-World Challenge | Number of Students | Percentage |
| :--- | :--- | :---: | :---: |
| **Q1** | Difficulty finding old study materials in WhatsApp groups | 51 / 56 | **91.1%** |
| **Q2** | Important department updates getting buried in group conversations | 49 / 56 | **87.5%** |
| **Q3** | Difficulty tracking subject-wise attendance in real time | 44 / 56 | **78.6%** |
| **Q4** | Lack of centralized previous-year papers and syllabus | 46 / 56 | **82.1%** |

### B. Proposed Features Usefulness ($Q_5 – Q_8$)
| Question Code | Proposed Portal Feature | Number of Students Rating "Useful / Very Useful" | Percentage |
| :--- | :--- | :---: | :---: |
| **Q5** | Centralized study materials & PDF repository | 53 / 56 | **94.6%** |
| **Q6** | Subject-wise attendance tracking feature | 48 / 56 | **85.7%** |
| **Q7** | Assignment and deadline management system | 47 / 56 | **83.9%** |
| **Q8** | Previous-year question papers & certification links | 49 / 56 | **87.5%** |

### C. Final Feature Priorities ($Q_9$)
Students were asked to select the portal features they want most:
1. **Study Materials:** **48 students (85.7%)** — *Highest Preference*
2. **Attendance Tracking:** **41 students (73.2%)** — *Second Highest Preference*
3. **Previous-Year Question Papers:** **31 students (55.4%)**
4. **Activities and Events Calendar:** **31 students (55.4%)**
5. **Online Courses & Certifications:** **31 students (55.4%)**

---

## 6. Requirement Analysis & Problem-Solution Matrix
The survey directly influenced the priority of the modules implemented in this system:

| Survey Challenge Identified | Demand % | Implemented Digital Solution |
| :--- | :---: | :--- |
| Old notes lost in WhatsApp chats | 91.1% | **Centralized Academic Resource Hub** with category filters, subject tags, and instant downloads. |
| Notices buried under chat spam | 87.5% | **Dedicated Notice Board & Announcement System** with category badges and priority tags. |
| Hard to track subject attendance | 78.6% | **Real-Time Attendance Engine** displaying subject-wise %, conducted classes, and VTU criteria alerts. |
| Inaccessible PYQ & Syllabus | 82.1% | **Integrated Examination & PYQ Archive** directly accessible by semester. |
| Missing assignment deadlines | 83.9% | **Assignment & Deadline Tracking System** with Pending/Due Soon/Submitted badges. |

---

## 7. Proposed System
The proposed system is an **Integrated Academic & Information Web Portal** that serves as the single source of truth for the Department of Computer Science & Engineering – ICB.

### Key Capabilities:
* **Role-Based Authorization:** Strict boundary separation between Students, Teachers, and Department Administration.
* **Unified Academic Hub:** Searchable, categorized repository for lecture notes, syllabus, PYQ papers, research surveys, and certification programs.
* **Database-Driven Operations:** Dynamic persistence with zero hardcoded mockup figures; real-time recalculation of student CGPA, attendance rates, and submission statuses.
* **Dual-Engine Persistence:** Native support for **MySQL Server 8.0** with automatic graceful fallback to an integrated relational store for zero-downtime demonstration on any evaluation environment.

---

## 8. System Architecture

```text
+-------------------------------------------------------------------------------+
|                                CLIENT FRONTEND                                |
|  - Modern Navy / Slate Aesthetic      - Responsive CSS3 Design System          |
|  - Plus Jakarta Sans Typography        - SVG Chart Analytics (Donuts / Trends) |
|  - Student Dashboard (1st Year)        - Teacher Dashboard (Prof. Sharma)      |
|  - Department Dashboard (Dr. Kumar)   - Survey & CBP Insights Hub             |
+-------------------------------------------------------------------------------+
                                        |  RESTful JSON API (HTTP/Fetch)
                                        v
+-------------------------------------------------------------------------------+
|                            EXPRESS.JS BACKEND SERVER                          |
|  - Modular REST Endpoints              - Multi-Role Authentication Logic       |
|  - Real-time Calculations              - Static Asset Delivery                 |
|  - Input Validation & Error Handling   - MySQL DB Adapter & Connection Pool    |
+-------------------------------------------------------------------------------+
                                        |
                 +----------------------+----------------------+
                 | (Primary Target)                            | (Resilient Fallback)
                 v                                             v
+------------------------------------+        +---------------------------------+
|       MySQL 8.0 RELATIONAL DB       |        |    INTEGRATED RELATIONAL STORE  |
|  - ksit_cse_icb Schema             |        |  - Fully Seeded Dual-Engine     |
|  - 18 Relational Tables            |        |  - Persistent JSON Storage      |
|  - Constraints & Foreign Keys      |        |  - Identical Schema & Queries   |
+------------------------------------+        +---------------------------------+
```

---

## 9. UI/UX Design System
The visual styling adheres strictly to the dashboard screenshots provided:
* **Sidebar:** Deep Navy (`#0b1329`), width 260px, fixed navigation with active blue pill highlights (`#2563eb`), white typography, KSIT logo crest, and motivational cards.
* **Dashboard Background:** Clean academic light slate (`#f4f6fa`).
* **Header:** Sticky white bar with universal search input, 1-click Role Switcher pills, real-time database connection badge, and notification bell.
* **Hero Banner:** KSIT campus building background with college name, motivational quotes, current date, and live Bengaluru weather widget (`28°C Partly Cloudy Bengaluru`).
* **Metric Cards:** Rounded cards (`border-radius: 12px`, soft box shadow) with colored icon boxes (Blue for Attendance, Green for CGPA, Purple for Exams, Red for Assignments).

---

## 10. Student Portal Features
1. **Dashboard:** Displays welcome hero, 4 summary metric cards (Attendance 92%, CGPA 8.12, Upcoming Exams 2, Pending Assignments 3), Today's Schedule (Periods 1 to 4 with tea break & room numbers), Quick Links (6 colorful buttons), Latest Announcements, Upcoming Events, and Your Progress meters.
2. **Academic Resource Hub:** Centralized system to filter by category (Lecture Notes, Syllabus, PYQ, Research Papers, Online Courses, Certifications), semester, and subject.
3. **Attendance Module:** Subject-wise breakdown, attended vs held classes, overall percentage radial gauge, and VTU criteria indicator.
4. **Assignments Module:** Tracks assignments across *Pending*, *Due Soon*, *Submitted*, and *Evaluated* states; includes file submission dialog.
5. **Examination Module:** Internal assessment test timetable, marks report card with letter grades, and syllabus question paper links.
6. **Notices & Circulars:** Filterable by Exams, General, CBP, Hostel, Placement.
7. **Events & Activities:** Technical talks, hackathons, and coding competitions with 1-click registration counter.
8. **Library:** Textbooks catalog with shelf rack numbers and digital eBook access.
9. **Placement & Career:** Job profiles (Infosys, TCS, Google Cloud), eligibility filters, packages, and application links.
10. **Profile & Settings:** USN, contact info, blood group, mentor details, and settings.

---

## 11. Teacher Portal Features
1. **Teacher Dashboard:** Displays metrics for assigned classes (120 Students, 4 Classes Today, 18 Pending Evaluations, 2 Notices), Today's Schedule, Class Overview circular progress metrics (Classes conducted 16/20 80%, Attendance rate 92%, Average marks 8.4/10), Attendance trend line chart (Your Classes vs Dept Avg), and Upcoming Evaluations table.
2. **Record Attendance:** Live roster table allowing teachers to mark Present/Absent/On-Duty for all students with 1-click "Mark All Present" and save directly to the database.
3. **Upload Study Materials:** Direct publishing form for syllabus, lecture notes, question papers, and course links into the Academic Hub.
4. **Manage Assignments:** Assignment creation with deadlines and max marks; grading panel to review student submissions and submit marks/feedback.
5. **Manage Marks:** Internal test score entry and evaluation.

---

## 12. Department / HOD Portal Features
1. **Department Dashboard:** Comprehensive statistics (420 Total Students, 32 Faculty Members, 24 Active Courses, 3 Upcoming Exams, 7 Pending Approvals), Class & Subject Overview table with tabs, Attendance Overview donut chart (Present 92%, Absent 5%, On Duty 2%, Leave 1%), and Student Strength Trend line graph (Sem 1 to Sem 8).
2. **Student Management:** Full student directory with search, semester filter, and enrollment dialog.
3. **Faculty Management:** Complete faculty roster with designations, qualifications, and cabin numbers.
4. **Attendance Analytics:** Department-wide attendance statistics and defaulter tracking (<75%).
5. **Examination & Approvals:** Internal marks moderation and approval queue.
6. **Database & System Configuration:** Live status inspector, host/port/user/password configuration form, and instant test & reconnect button.

---

## 13. Database Design & Relational Tables
Designed and implemented in `database/schema.sql` and `database/seed.sql`:
1. `users` — Authentication credentials, role enums (`student`, `teacher`, `department`).
2. `students` — USN, semester, section, CGPA, attendance count, mentor name.
3. `teachers` — Employee ID, designation, qualification, cabin number.
4. `subjects` — Code, name, semester, credits, assigned faculty.
5. `timetable` — Day of week, period number, time slot, subject, room number.
6. `attendance` — Student ID, subject ID, date, status, marked by.
7. `study_materials` — Title, description, category, subject, semester, file/URL.
8. `assignments` — Title, subject, semester, deadline, max marks, description.
9. `assignment_submissions` — Student ID, submission date, file, marks, feedback.
10. `examinations` — Title, exam type, date, time slot, room number.
11. `exam_marks` — Student ID, subject, exam type, marks obtained, grade.
12. `notices` — Title, description, category, priority, target role, date posted.
13. `events` — Title, category, event date, time range, venue, organizer.
14. `library_resources` — Title, author, ISBN, category, semester, copies, rack.
15. `placements` — Company name, job title, role type, package, deadline, link.
16. `community_activities` — Project title, team name, members, mentor, status.
17. `survey_responses` — Authentic survey questions, counts, percentages.
18. `notifications` — User ID, title, message, read status, timestamp.

---

## 14. Implementation Details
* **Backend:** Node.js (v24.14.0) with Express.js (v5.2.1), CORS, Dotenv, and MySQL2.
* **Frontend:** Clean Vanilla HTML5/CSS3/JavaScript ensuring high performance, zero build dependencies, and instant client rendering.
* **Visual Match:** Pixel-perfect alignment with provided reference screenshots including colors, spacing, typography, and card hierarchy.

---

## 15. Testing & Verification
* **Unit & API Testing:** Verified that all 12 core REST endpoints return 200 OK with valid JSON payloads.
* **Role Verification:** Verified seamless switching between Student, Teacher, and Department views.
* **Database Resiliency:** Tested auto-fallback when MySQL credentials require password; verified web-based configuration panel for live reconnection.
* **Form Interactions:** Tested attendance recording, assignment submission, resource upload, and student enrollment modals.

---

## 16. Deployment
* **Local Run:** `node server.js` on `http://localhost:3000`.
* **Port Configuration:** Easily customizable via `.env` or `PORT` environment variable.
* **Zero Configuration:** Works immediately out-of-the-box on any development machine.

---

## 17. Community Impact
By centralizing academic information, this CBP directly benefits:
* **56+ First-Year Students:** Eliminates frustration and lost revision time caused by WhatsApp chat clutter.
* **Department Faculty:** Saves hours of manual attendance collation and assignment tracking.
* **Institution (KSIT):** Provides clean digital audit trails for NBA and NAAC accreditation documentation.

---

## 18. Future Scope
* Android/iOS mobile application wrapper using Capacitor/React Native.
* Real-time automated WhatsApp/SMS push gateway integration via Twilio for emergency circulars.
* AI-driven syllabus Q&A bot to answer student queries about exam dates and lecture notes automatically.

---

## 19. Conclusion
The **CSE (ICB) Department Integrated Academic and Information Portal** successfully transitions the department from scattered, disorganized channels to **"One Platform. One Department. Better Academic Management."** Rooted in real student survey data and engineered with production-grade web technologies, it stands as a complete, functioning Community-Based Project for KSIT Bengaluru.
