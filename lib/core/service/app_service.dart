import 'package:flutter/material.dart';
import '../errors/exceptions.dart';
import 'local_storage_service.dart';
import 'network_service.dart';

class AppService {
  final LocalStorageService localStorage;
  final NetworkService networkService;

  AppService({
    required this.localStorage,
    required this.networkService,
  });

  /// يتم استدعاؤه في main() قبل تشغيل التطبيق
  Future<void> initApp() async {
    debugPrint('⚙️ AppService: Starting initialization...');

    await _checkNetwork();
    await _loadInitialSettings();
    await _checkUserAuth();

    debugPrint('✅ AppService: Initialization complete.');
  }

  /// تحقق من وجود إنترنت
 Future<void> _checkNetwork() async {
  final hasInternet = await networkService.hasInternet();
  if (!hasInternet) {
    throw NetworkException();
  }
}


  /// تحميل إعدادات أولية (مثلاً الوضع الداكن أو اللغة لاحقًا)
  Future<void> _loadInitialSettings() async {
    // TODO: تحميل اللغة أو الثيم
  }

  /// تحقق من وجود مستخدم مخزن
 Future<void> _checkUserAuth() async {
  final userId = localStorage.getUserId();
  final userType = localStorage.getUserType();
  if (userId != null && userType != null) {
    debugPrint('🔐 User is logged in as $userType');
  } else {
    debugPrint('🔓 No user logged in');
  }
}

}
