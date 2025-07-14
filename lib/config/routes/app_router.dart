// lib/config/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:taba3ni/features/auth/presentation/pages/auth_gate.dart';
import 'package:taba3ni/features/auth/presentation/pages/parent_login_page.dart';
import 'package:taba3ni/features/auth/presentation/pages/teacher_login_page.dart';
import 'package:taba3ni/features/auth/presentation/pages/user_type_selector_page.dart';
// import more as needed

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.authGate:
        return MaterialPageRoute(
          builder: (_) => const AuthGate(),
        );
      case AppRoutes.userTypeSelector:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const UserTypeSelectorPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          
        );
      case AppRoutes.teacherLogin:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const TeacherLoginPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      case AppRoutes.parentLogin:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ParentLoginPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 – Page not found')),
              ),
        );
    }
  }
}
