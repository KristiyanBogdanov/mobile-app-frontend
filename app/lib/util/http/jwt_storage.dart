import 'package:shared_preferences/shared_preferences.dart';

class JwtStorage {
  static const _tokenKey = 'jwt_token';
  String _token = '';

  Future<void> saveToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, token);
  }

  Future<String> getToken() async {
    if (_token.isNotEmpty) {
      return _token;
    }

    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey) ?? '';

    return _token;
  }

  Future<void> deleteToken() async {
    _token = '';
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
  }
}
