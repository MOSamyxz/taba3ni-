import 'package:flutter/material.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/core/service/local_storage_service.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(milliseconds: 500)); // خفة وانتقال لطيف
    if (!mounted) return;
    final localStorage = sl<LocalStorageService>();

    if (!localStorage.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, AppRoutes.userTypeSelector);
    } else {
      if (localStorage.getUserType() == 'teacher') {
        Navigator.pushReplacementNamed(context, AppRoutes.homeTeacher);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.homeParent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
