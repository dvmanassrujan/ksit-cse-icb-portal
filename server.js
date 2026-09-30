/**
 * CSE (ICB) Department Integrated Academic and Information Portal
 * Express Backend Server
 * K. S. Institute of Technology (KSIT), Bengaluru
 */

const express = require('express');
const cors = require('cors');
const path = require('path');
const db = require('./db');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static frontend files from 'public' directory
app.use(express.static(path.join(__dirname, 'public')));
// Also serve root directory images if requested
app.use('/assets/raw', express.static(path.join(__dirname)));

// ---------------- API ROUTES ----------------

// System Health & DB Engine Status
app.get('/api/health', (req, res) => {
  res.json({
    status: 'online',
    portal: 'CSE (ICB) Department Integrated Academic & Information Portal',
    institution: 'K. S. Institute of Technology (KSIT), Bengaluru',
    team: 'STACK X (D V Manas Srujan, Hussain Basha, M Pavani Gowda, Purvi B V)',
    database: db.getStatus()
  });
});

// Configure MySQL Credentials on the fly
app.post('/api/db/configure', async (req, res) => {
  const { host, port, user, password, database } = req.body;
  if (host) process.env.DB_HOST = host;
  if (port) process.env.DB_PORT = port;
  if (user) process.env.DB_USER = user;
  if (password !== undefined) process.env.DB_PASSWORD = password;
  if (database) process.env.DB_NAME = database;

  const result = await db.initDb();
  res.json({
    message: result.success ? 'Connected to MySQL successfully!' : 'Falling back to Integrated Relational Store: ' + result.error,
    database: db.getStatus()
  });
});

// Auth / Role Accounts
app.get('/api/auth/roles', (req, res) => {
  const store = db.getDbStore();
  const accounts = [
    { id: 1, username: 'hussain', role: 'student', name: 'Hussain Basha', subtitle: '1st Year • CSE (ICB)', usn: '1KS25IC023' },
    { id: 2, username: 'manas', role: 'student', name: 'D V Manas Srujan', subtitle: '1st Year • CSE (ICB)', usn: '1KS25IC015' },
    { id: 5, username: 'prof_sharma', role: 'teacher', name: 'Prof. R. Sharma', subtitle: 'Assistant Professor • CSE (ICB)', empid: 'KSIT-FAC-014' },
    { id: 8, username: 'dr_kumar', role: 'department', name: 'Dr. R. Kumar', subtitle: 'HOD • CSE (ICB)', empid: 'KSIT-HOD-001' }
  ];
  res.json(accounts);
});

app.post('/api/auth/login', (req, res) => {
  const { username, password, role } = req.body;
  const store = db.getDbStore();

  let user = null;
  if (username) {
    user = store.users.find(u => u.username.toLowerCase() === username.toLowerCase().trim());
  } else if (role) {
    user = store.users.find(u => u.role === role);
  }

  if (!user) {
    return res.status(401).json({ error: 'User not found. Try demo users: hussain, prof_sharma, or dr_kumar.' });
  }

  // Get role specific profile
  let profile = {};
  if (user.role === 'student') {
    profile = store.students.find(s => s.user_id === user.id) || store.students[0];
  } else if (user.role === 'teacher') {
    profile = store.teachers.find(t => t.user_id === user.id) || store.teachers[0];
  } else {
    profile = { designation: 'Head of Department', department: 'CSE (ICB)', employee_id: 'KSIT-HOD-001' };
  }

  res.json({
    user: {
      id: user.id,
      username: user.username,
      name: user.name,
      role: user.role,
      email: user.email,
      avatar_url: user.avatar_url
    },
    profile
  });
});

// 1. Student Dashboard Data
app.get('/api/dashboard/student', (req, res) => {
  const store = db.getDbStore();
  const student = store.students[0]; // Hussain Basha by default

  res.json({
    student: {
      name: student.name,
      usn: student.usn,
      year: student.year,
      semester: student.semester,
      department: student.department,
      institution: 'K. S. Institute of Technology, Bengaluru',
      welcomeQuote: 'The future belongs to those who keep learning.',
      subQuoteTag: 'Learn • Build • Grow',
      date: 'Monday, 29 Sep 2025',
      weather: '28°C Partly Cloudy Bengaluru'
    },
    summaryCards: {
      attendance: {
        percentage: '92%',
        sublabel: `Present Days: ${student.present_days} / ${student.total_days}`,
        icon: 'attendance'
      },
      cgpa: {
        score: student.cgpa.toFixed(2),
        grade: 'A+',
        sublabel: 'Sem 1 • 1st Year',
        icon: 'cgpa'
      },
      upcomingExams: {
        count: 2,
        sublabel: 'Next: Maths (12 Oct 2025)',
        icon: 'exam'
      },
      pendingAssignments: {
        count: 3,
        sublabel: 'Due this week',
        icon: 'assignment'
      }
    },
    schedule: store.timetable,
    quickLinks: [
      { id: 1, label: 'View Attendance', icon: 'attendance', color: '#10b981', target: 'attendance' },
      { id: 2, label: 'Exam Results', icon: 'exam', color: '#8b5cf6', target: 'examination' },
      { id: 3, label: 'Download Notes', icon: 'notes', color: '#3b82f6', target: 'academics' },
      { id: 4, label: 'Library Portal', icon: 'library', color: '#f97316', target: 'library' },
      { id: 5, label: 'Fee Payment', icon: 'payment', color: '#ec4899', target: 'external-fee' },
      { id: 6, label: 'Bus Pass', icon: 'bus', color: '#06b6d4', target: 'external-bus' }
    ],
    announcements: store.notices.filter(n => n.target_role === 'student' || n.target_role === 'all'),
    upcomingEvents: store.events.slice(0, 3),
    progress: [
      { name: 'Academics', percentage: 68, color: '#3b82f6' },
      { name: 'Coding Practice', percentage: 45, color: '#10b981' },
      { name: 'Communication Skills', percentage: 30, color: '#8b5cf6' },
      { name: 'Fitness & Health', percentage: 55, color: '#f97316' }
    ]
  });
});

// 2. Teacher Dashboard Data
app.get('/api/dashboard/teacher', (req, res) => {
  const store = db.getDbStore();
  const teacher = store.teachers[0]; // Prof. R. Sharma

  res.json({
    teacher: {
      name: teacher.name,
      designation: teacher.designation,
      department: teacher.department,
      quote: '"Education is the most powerful weapon which you can use to change the world." - Nelson Mandela',
      date: 'Monday, 29 Sep 2025',
      academicYear: '2025 - 26'
    },
    summaryCards: {
      totalStudents: {
        count: teacher.total_students,
        label: 'Total Students (Your Classes)',
        sublabel: '+2 new enrollments',
        icon: 'students'
      },
      classesToday: {
        count: teacher.classes_today,
        label: 'Classes Today',
        sublabel: '3 completed | 1 upcoming',
        icon: 'classes'
      },
      pendingEvaluations: {
        count: teacher.pending_evaluations,
        label: 'Pending Evaluations',
        sublabel: 'Assignments / Test Papers',
        icon: 'evaluations'
      },
      notices: {
        count: teacher.notices_count,
        label: 'Notices & Updates',
        sublabel: 'New department notices',
        icon: 'notices'
      }
    },
    todaySchedule: [
      { period: 'P1', time: '08:30 - 09:25', subject: 'Mathematics (CSE-ICB)', room: 'Room: C-204 | 3rd Sem', status: 'Completed' },
      { period: 'P2', time: '09:25 - 10:20', subject: 'Physics (CSE-ICB)', room: 'Room: C-204 | 3rd Sem', status: 'Completed' },
      { period: 'BREAK', time: '10:20 - 10:35', subject: 'Tea Break', room: 'Faculty Lounge', status: 'Break' },
      { period: 'P3', time: '10:35 - 11:30', subject: 'Programming in C (CSE-ICB)', room: 'Room: C-204 | 3rd Sem', status: 'Completed' },
      { period: 'P4', time: '11:30 - 12:25', subject: 'Engineering Graphics (CSE-ICB)', room: 'Room: C-204 | 3rd Sem', status: 'Upcoming' }
    ],
    classOverview: store.teacher_overview.class_metrics,
    attendanceTrend: store.teacher_overview.attendance_trend,
    upcomingEvaluations: store.teacher_overview.upcoming_evaluations,
    recentNotices: store.notices.slice(0, 4)
  });
});

// 3. Department Dashboard Data
app.get('/api/dashboard/department', (req, res) => {
  const store = db.getDbStore();
  const dept = store.department_overview;

  res.json({
    admin: {
      name: 'Dr. R. Kumar',
      title: 'Department Staff Dashboard | CSE (ICB)',
      quote: '"Education is the most powerful weapon which you can use to change the world." - Nelson Mandela',
      date: 'Monday, 29 Sep 2025',
      academicYear: '2025 - 26'
    },
    summaryCards: {
      totalStudents: { count: dept.total_students, delta: `+${dept.new_students_month} new this month`, label: 'Total Students (Department)' },
      facultyMembers: { count: dept.faculty_members, delta: `+${dept.new_faculty} new joiner`, label: 'Faculty Members' },
      activeCourses: { count: dept.active_courses, delta: dept.semester_term, label: 'Active Courses' },
      upcomingExams: { count: dept.upcoming_examinations, delta: '(Next 2 weeks)', label: 'Upcoming Examinations' },
      pendingApprovals: { count: dept.pending_approvals, delta: '(Result entry / Marks / Others)', label: 'Pending Approvals' }
    },
    classesOverview: dept.classes_overview,
    attendanceOverview: dept.attendance_analytics,
    studentStrengthTrend: dept.student_strength_trend,
    examinationSummary: dept.examination_summary,
    upcomingEvents: store.events.slice(0, 3),
    recentNotices: store.notices.slice(0, 4)
  });
});

// 4. Academic Resource Hub (Centralized study materials, syllabus, PYQ, research papers, courses, certifications)
app.get('/api/resources', (req, res) => {
  const store = db.getDbStore();
  let items = [...store.study_materials];

  const { category, semester, search } = req.query;

  if (category && category !== 'all') {
    items = items.filter(r => r.category.toLowerCase() === category.toLowerCase());
  }

  if (semester && semester !== 'all') {
    items = items.filter(r => r.semester === parseInt(semester, 10));
  }

  if (search) {
    const s = search.toLowerCase();
    items = items.filter(r =>
      r.title.toLowerCase().includes(s) ||
      (r.description && r.description.toLowerCase().includes(s)) ||
      (r.subject_name && r.subject_name.toLowerCase().includes(s))
    );
  }

  res.json({
    total: items.length,
    resources: items
  });
});

app.post('/api/resources', (req, res) => {
  const store = db.getDbStore();
  const { title, description, category, semester, subject_name, external_url, uploaded_by } = req.body;

  if (!title || !category) {
    return res.status(400).json({ error: 'Title and Category are required.' });
  }

  const newResource = {
    id: store.study_materials.length + 1,
    title,
    description: description || 'Academic resource uploaded by faculty.',
    category,
    subject_id: 1,
    subject_name: subject_name || 'General Engineering',
    semester: parseInt(semester, 10) || 1,
    file_url: `/downloads/resource_${Date.now()}.pdf`,
    external_url: external_url || null,
    file_size: '2.5 MB',
    file_type: external_url ? 'LINK' : 'PDF',
    uploaded_by: uploaded_by || 'Prof. R. Sharma',
    downloads_count: 0,
    created_at: new Date().toISOString().split('T')[0]
  };

  store.study_materials.unshift(newResource);
  db.saveMemoryDb();

  // Create notification for students
  store.notifications.unshift({
    id: store.notifications.length + 1,
    user_id: 1,
    title: 'New Study Material Available',
    message: `${newResource.title} has been added to Academic Hub.`,
    type: 'resource',
    is_read: false,
    time: 'Just now'
  });

  res.status(201).json({ message: 'Resource published successfully!', resource: newResource });
});

// 5. Attendance Module
app.get('/api/attendance/student/:id', (req, res) => {
  const store = db.getDbStore();
  const student = store.students.find(s => s.id === parseInt(req.params.id, 10)) || store.students[0];
  
  res.json({
    student_id: student.id,
    student_name: student.name,
    overall_percentage: student.attendance_pct,
    present_days: student.present_days,
    total_days: student.total_days,
    subject_wise: store.attendance.filter(a => a.student_id === student.id),
    status: student.attendance_pct >= 75 ? 'Eligible for Exams (>75%)' : 'Defaulter Alert (<75%)'
  });
});

app.post('/api/attendance/record', (req, res) => {
  const store = db.getDbStore();
  const { subject_name, date, records } = req.body;

  // records = [{ student_id: 1, status: 'present' }, ...]
  if (Array.isArray(records)) {
    records.forEach(r => {
      const student = store.students.find(s => s.id === r.student_id);
      if (student) {
        student.total_days += 1;
        if (r.status === 'present') {
          student.present_days += 1;
        }
        student.attendance_pct = Math.round((student.present_days / student.total_days) * 100);
      }
    });
    db.saveMemoryDb();
  }

  res.json({ message: 'Attendance recorded successfully for ' + (subject_name || 'Class') + ' on ' + (date || 'Today') });
});

// 6. Assignments Module
app.get('/api/assignments', (req, res) => {
  const store = db.getDbStore();
  const { status } = req.query;
  let items = [...store.assignments];
  if (status && status !== 'all') {
    items = items.filter(a => a.status === status);
  }
  res.json(items);
});

app.post('/api/assignments', (req, res) => {
  const store = db.getDbStore();
  const { title, subject_name, semester, deadline, max_marks, description } = req.body;

  if (!title || !subject_name || !deadline) {
    return res.status(400).json({ error: 'Title, Subject, and Deadline are required.' });
  }

  const newAssignment = {
    id: store.assignments.length + 1,
    title,
    subject_name,
    subject_id: 1,
    semester: parseInt(semester, 10) || 1,
    faculty_name: 'Prof. R. Sharma',
    description: description || 'Solve and upload assigned questions.',
    created_date: new Date().toISOString().split('T')[0],
    deadline,
    max_marks: parseInt(max_marks, 10) || 20,
    status: 'pending',
    submitted_date: null,
    marks_obtained: null,
    feedback: null
  };

  store.assignments.unshift(newAssignment);
  db.saveMemoryDb();

  res.status(201).json({ message: 'Assignment created successfully!', assignment: newAssignment });
});

app.post('/api/assignments/:id/submit', (req, res) => {
  const store = db.getDbStore();
  const assignmentId = parseInt(req.params.id, 10);
  const assignment = store.assignments.find(a => a.id === assignmentId);

  if (!assignment) {
    return res.status(404).json({ error: 'Assignment not found.' });
  }

  assignment.status = 'submitted';
  assignment.submitted_date = new Date().toISOString().split('T')[0];

  const submission = {
    id: store.assignment_submissions.length + 1,
    assignment_id: assignmentId,
    student_id: 1,
    student_name: 'Hussain Basha',
    usn: '1KS25IC023',
    submission_date: new Date().toLocaleString(),
    submission_file: req.body.fileName || 'assignment_submission.pdf',
    status: 'submitted',
    marks_obtained: null,
    feedback: 'Awaiting faculty evaluation'
  };

  store.assignment_submissions.push(submission);
  db.saveMemoryDb();

  res.json({ message: 'Assignment submitted successfully!', assignment });
});

app.post('/api/assignments/:id/evaluate', (req, res) => {
  const store = db.getDbStore();
  const assignmentId = parseInt(req.params.id, 10);
  const { marks_obtained, feedback } = req.body;

  const assignment = store.assignments.find(a => a.id === assignmentId);
  if (assignment) {
    assignment.status = 'evaluated';
    assignment.marks_obtained = parseFloat(marks_obtained);
    assignment.feedback = feedback || 'Evaluated successfully.';
  }

  const sub = store.assignment_submissions.find(s => s.assignment_id === assignmentId);
  if (sub) {
    sub.status = 'evaluated';
    sub.marks_obtained = parseFloat(marks_obtained);
    sub.feedback = feedback;
  }

  db.saveMemoryDb();
  res.json({ message: 'Assignment evaluated successfully!', assignment });
});

// 7. Notices & Announcements Module
app.get('/api/notices', (req, res) => {
  const store = db.getDbStore();
  const { category, search } = req.query;
  let items = [...store.notices];

  if (category && category !== 'all') {
    items = items.filter(n => n.category.toLowerCase() === category.toLowerCase());
  }

  if (search) {
    const s = search.toLowerCase();
    items = items.filter(n => n.title.toLowerCase().includes(s) || n.description.toLowerCase().includes(s));
  }

  res.json(items);
});

app.post('/api/notices', (req, res) => {
  const store = db.getDbStore();
  const { title, description, category, priority, target_role } = req.body;

  if (!title || !description) {
    return res.status(400).json({ error: 'Title and description are required.' });
  }

  const newNotice = {
    id: store.notices.length + 1,
    title,
    description,
    category: category || 'General',
    priority: priority || 'Normal',
    is_new: true,
    target_role: target_role || 'all',
    date_posted: new Date().toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
    author: req.body.author || 'Department Office'
  };

  store.notices.unshift(newNotice);
  db.saveMemoryDb();

  res.status(201).json({ message: 'Notice posted successfully!', notice: newNotice });
});

// 8. Survey Driven Development & Insights
app.get('/api/survey/results', (req, res) => {
  const store = db.getDbStore();
  res.json({
    title: 'Student Community Survey Results (26/09/2026)',
    total_surveyed: 56,
    target_group: 'First-Year Engineering & CSE (ICB) Students',
    presentation_reference: 'Slides 6, 7 & 8',
    summary: 'Survey shows finding old study material is a major difficulty (91.1%), while important updates are missed in WhatsApp group conversations (87.5%). Highest preference was study materials (85.7%), followed by attendance tracking (73.2%).',
    responses: store.survey_responses,
    feature_priorities: [
      { feature: 'Study Materials', count: 48, percentage: 85.7, rank: 1, implemented: true, module: 'Academic Resource Hub' },
      { feature: 'Attendance Tracking', count: 41, percentage: 73.2, rank: 2, implemented: true, module: 'Attendance System' },
      { feature: 'Previous-Year Question Papers', count: 31, percentage: 55.4, rank: 3, implemented: true, module: 'PYQ Archive' },
      { feature: 'Activities & Events Calendar', count: 31, percentage: 55.4, rank: 4, implemented: true, module: 'Events & Activities' },
      { feature: 'Courses & Certifications', count: 31, percentage: 55.4, rank: 5, implemented: true, module: 'Career & Certifications' }
    ]
  });
});

// 9. Examination & Marks
app.get('/api/examinations', (req, res) => {
  const store = db.getDbStore();
  res.json(store.examinations);
});

app.get('/api/marks/student/:id', (req, res) => {
  const store = db.getDbStore();
  res.json(store.exam_marks);
});

// 10. Students & Faculty Directory
app.get('/api/students', (req, res) => {
  const store = db.getDbStore();
  res.json(store.students);
});

app.post('/api/students', (req, res) => {
  const store = db.getDbStore();
  const { name, usn, semester, section } = req.body;

  if (!name || !usn) {
    return res.status(400).json({ error: 'Name and USN are required.' });
  }

  const newStudent = {
    id: store.students.length + 1,
    user_id: store.users.length + 1,
    usn: usn.toUpperCase(),
    name,
    year: '1st Year',
    semester: parseInt(semester, 10) || 1,
    section: section || 'A',
    department: 'CSE (ICB)',
    cgpa: 8.00,
    present_days: 0,
    total_days: 0,
    attendance_pct: 100,
    blood_group: 'B+',
    mentor_name: 'Prof. R. Sharma'
  };

  store.students.push(newStudent);
  db.saveMemoryDb();

  res.status(201).json({ message: 'Student enrolled successfully!', student: newStudent });
});

app.get('/api/faculty', (req, res) => {
  const store = db.getDbStore();
  res.json(store.teachers);
});

// 11. Events, Library, Placements, Community Activities
app.get('/api/events', (req, res) => {
  const store = db.getDbStore();
  res.json(store.events);
});

app.get('/api/library', (req, res) => {
  const store = db.getDbStore();
  res.json(store.library_resources);
});

app.get('/api/placements', (req, res) => {
  const store = db.getDbStore();
  res.json(store.placements);
});

app.get('/api/community-project', (req, res) => {
  const store = db.getDbStore();
  res.json(store.community_activities);
});

app.get('/api/notifications', (req, res) => {
  const store = db.getDbStore();
  res.json(store.notifications);
});

// Root fallback: serve index.html for Single Page Application
app.use((req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Start Server
async function start() {
  await db.initDb();
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`\n================================================================`);
    console.log(`  KSIT CSE (ICB) Academic & Information Portal is running!`);
    console.log(`  Local URL: http://localhost:${PORT}`);
    console.log(`  Student, Teacher & Department Portals are active`);
    console.log(`================================================================\n`);
  });
}

start();
