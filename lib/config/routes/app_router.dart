import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/features/add_student/presentation/page/add_student_page.dart';
import 'package:taba3ni/features/auth/presentation/pages/auth_gate.dart';
import 'package:taba3ni/features/auth/presentation/pages/parent_login_page.dart';
import 'package:taba3ni/features/auth/presentation/pages/teacher_login_page.dart';
import 'package:taba3ni/features/auth/presentation/pages/user_type_selector_page.dart';
import 'package:taba3ni/features/group_details/presentation/page/group_details.dart';
import 'package:taba3ni/features/add_group/presentation/page/add_group_page.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/presentation/page/group_page.dart';
import 'package:taba3ni/features/layout/page/layout_page.dart';
import 'package:taba3ni/features/lesson_attendance/presentation/page/lesson_attendance_page.dart';
import 'package:taba3ni/features/start_lesson/presentation/page/start_lesson_page.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.authGate,
  routes: [
    GoRoute(
      path: AppRoutes.authGate,
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: AppRoutes.userTypeSelector,
      pageBuilder:
          (context, state) =>
              _buildFadeTransition(const UserTypeSelectorPage()),
    ),
    GoRoute(
      path: AppRoutes.teacherLogin,
      pageBuilder:
          (context, state) => _buildFadeTransition(const TeacherLoginPage()),
    ),
    GoRoute(
      path: AppRoutes.parentLogin,
      pageBuilder:
          (context, state) => _buildFadeTransition(const ParentLoginPage()),
    ),
    GoRoute(
      path: AppRoutes.layoutScreen,
      builder: (context, state) => const LayoutScreen(),
    ),
    GoRoute(
      path: AppRoutes.groupPage,
      pageBuilder:
          (context, state) => _buildFadeTransition(
            const GroupPage(),
          ),
    ),
    GoRoute(
      path: AppRoutes.addGroup,
      pageBuilder:
          (context, state) => _buildFadeTransition(
            AddGroupPage(group: state.extra as GroupEntity?),
          ),
    ),
    GoRoute(
      path: AppRoutes.groupDetails,
      pageBuilder:
          (context, state) => _buildFadeTransition(
            GroupDetailsPage(groupId: state.extra as String),
          ),
    ),
    GoRoute(
      path: AppRoutes.lessonAttendance,

      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        final groupId = extra['groupId'] as String;
        final lessonId = extra['lessonId'] as String;
        return _buildFadeTransition(
          LessonAttendancePage(groupId: groupId, lessonId: lessonId),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.startLesson,

      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final groupId = extra['groupId'] as String;
        final students = extra['students'] as List<StudentsEntity>;
        return _buildFadeTransition(
          StartLessonPage(groupId: groupId, students: students),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.addStudent,

      pageBuilder:
          (context, state) => _buildFadeTransition(
            AddStudentPage(groupId: state.extra as String),
          ),
    ),
  ],
  errorBuilder:
      (context, state) =>
          const Scaffold(body: Center(child: Text('404 – Page not found'))),
);

CustomTransitionPage _buildFadeTransition(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
  );
}
