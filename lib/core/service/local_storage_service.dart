import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  String? getToken() {
    return _prefs.getString('token');
  }

  Future<void> removeToken() async {
    await _prefs.remove('token');
  }

  Future<void> saveLangCode(String code) async {
    await _prefs.setString('lang_code', code);
  }

  String? getLangCode() => _prefs.getString('lang_code');

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
