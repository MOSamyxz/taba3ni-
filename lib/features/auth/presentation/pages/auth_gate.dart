import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    final localStorage = sl<LocalStorageService>();

    if (!localStorage.isLoggedIn()) {
      context.go(AppRoutes.userTypeSelector);
    } else {
      if (localStorage.getUserType() == 'teacher') {
        context.go(AppRoutes.layoutScreen);
      } else {
        context.go(AppRoutes.homeParent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
