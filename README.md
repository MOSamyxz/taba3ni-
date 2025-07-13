# 📚 Taba3ni – Student Tracking App

**Taba3ni** is a mobile application designed for **Mr. Mohamed El-Masry**, a mathematics teacher for preparatory and secondary students.  
The app streamlines group management, tracks student attendance, monitors monthly payments, and provides guardians with full visibility over their child's progress.

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-Mobile-blue.svg?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-Language-0175C2.svg?logo=dart&logoColor=white)](https://dart.dev/)
[![Supabase](https://img.shields.io/badge/Supabase-Backend-3FCF8E.svg?logo=supabase&logoColor=white)](https://supabase.com/)

*An advanced Smart Home automation system integrating IoT sensors, real-time monitoring, device control, and blockchain-secured transaction logging.*

</div>

---

## 🧠 Project Idea

A smart, lightweight mobile platform to help private tutors:

- Create and manage multiple class groups
- Manually add students to groups
- Log student attendance for every session
- Track monthly payments to prevent delays
- [Upcoming] Assign scores based on student performance and engagement
- Enable parents to monitor their child using a secure student code

---

## 🛠️ Tech Stack

| Tool / Tech            | Purpose                            |
|------------------------|------------------------------------|
| **Flutter**            | Cross-platform mobile development  |
| **Supabase**           | Backend-as-a-service (Auth & DB)   |
| **Dart**               | Core programming language          |
| **Cubit + Clean Arch** | State management & code separation |
| **SharedPreferences**  | Local storage                      |
| **connectivity_plus**  | Internet connectivity check        |
| **GitHub**             | Version control & collaboration    |

---

## 🧱 Project Structure

```
lib/
├── core/               # App-wide config (colors, themes, errors, services)
│   ├── errors/
│   ├── services/
│   ├── utils/
│   ├── theme/
│   └── constants/
├── features/           # Modular features (auth, groups, students...)
│   └── auth/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── main.dart           # Application entry point
```

## 👥 User Types

### 🧑‍🏫 Teacher (Admin)

Create & manage class groups

Add students with their guardians' contact info

Log attendance and payment manually

Weekly reports sent automatically

### 👨‍👩‍👧 Guardian

Sign in using the student’s unique code

Monitor attendance, payments, and scores

Receive alerts for absence, delays, or dues

---

## 🚀 Getting Started

Clone the project and run:

```
git clone https://github.com/MOSamyxz/taba3ni.git
cd taba3ni
flutter pub get
flutter run
```

---

## 📈 Future Roadmap

 Student score system (based on session activity, quizzes, homework)

 Weekly analytics report with performance graphs

 Chat system between teachers and guardians

 Push Notifications

 Multiple subjects and teachers support

 ---

 ## 🔐 License & Ownership
 
This project is a custom-built solution for Mr. Mohamed El-Masry and is not open for commercial redistribution.
The platform may be extended in the future to serve other educators under a SaaS model.

---

## 👨‍💻 Developer

Developed by:
Mo Samy
📧 moosamyz9@gmail.com
🐙 GitHub: MOSamyxz


