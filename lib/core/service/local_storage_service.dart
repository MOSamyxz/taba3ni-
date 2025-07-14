import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  Future<void> saveUser({
    required String id,
    required String type, // 'teacher' or 'parent'
    required String name,
  }) async {
    await prefs.setString('user_id', id);
    await prefs.setString('user_type', type);
    await prefs.setString('user_name', name);
  }

  String? getUserId() => prefs.getString('user_id');
  String? getUserType() => prefs.getString('user_type');
  String? getUserName() => prefs.getString('user_name');

  Future<void> clearUser() async {
    await prefs.remove('user_id');
    await prefs.remove('user_type');
    await prefs.remove('user_name');
  }

  bool isLoggedIn() => prefs.containsKey('user_id');
}

