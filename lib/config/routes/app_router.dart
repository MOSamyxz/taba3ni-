import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/features/auth/presentation/pages/auth_gate.dart';
import 'package:taba3ni/features/auth/presentation/pages/parent_login_page.dart';
import 'package:taba3ni/features/auth/presentation/pages/teacher_login_page.dart';
import 'package:taba3ni/features/auth/presentation/pages/user_type_selector_page.dart';
import 'package:taba3ni/features/group_details/presentation/page/group_details.dart';
import 'package:taba3ni/features/add_group/presentation/page/add_group_page.dart';
import 'package:taba3ni/features/groups/presentation/page/group_page.dart';
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
      pageBuilder: (context, state) => _buildFadeTransition(const UserTypeSelectorPage()),
    ),
    GoRoute(
      path: AppRoutes.teacherLogin,
      pageBuilder: (context, state) => _buildFadeTransition(const TeacherLoginPage()),
    ),
    GoRoute(
      path: AppRoutes.parentLogin,
      pageBuilder: (context, state) => _buildFadeTransition(const ParentLoginPage()),
    ),
    GoRoute(
      path: AppRoutes.groupPage,
      pageBuilder: (context, state) => _buildFadeTransition(
        const GroupPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.addGroup,
      pageBuilder: (context, state) => _buildFadeTransition(AddGroupPage()),
    ),
    GoRoute(
      path: AppRoutes.groupDetails,
      pageBuilder: (context, state) => _buildFadeTransition(
        GroupDetailsPage(groupId: state.extra as String),
      ))
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('404 – Page not found')),
  ),
);

CustomTransitionPage _buildFadeTransition(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
