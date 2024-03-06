import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static TokenService? _instance;
  late SharedPreferences _prefs;

  TokenService._privateConstructor() {
    _initPrefs();
  }

  static Future<TokenService> getInstance() async {
    _instance ??= TokenService._privateConstructor();
    return _instance!;
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  Future<void> removeToken() async {
    await _prefs.remove('token');
  }
}
