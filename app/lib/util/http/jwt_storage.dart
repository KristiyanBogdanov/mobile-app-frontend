import 'package:shared_preferences/shared_preferences.dart';

class JwtStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  String _accessToken = '';
  String _refreshToken = '';

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_accessTokenKey, accessToken);
    prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<String> getAccessToken() async {
    if (_accessToken.isNotEmpty) {
      return _accessToken;
    }

    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString(_accessTokenKey) ?? '';

    return _accessToken;
  }

  Future<String> getRefreshToken() async {
    if (_refreshToken.isNotEmpty) {
      return _refreshToken;
    }

    final prefs = await SharedPreferences.getInstance();
    _refreshToken = prefs.getString(_refreshTokenKey) ?? '';

    return _refreshToken;
  }

  // TODO: test for potential bug due to async nature of this method
  Future<bool> hasTokens() async {
    final [accessToken, refreshToken] = await Future.wait([
      getAccessToken(),
      getRefreshToken(),
    ]);

    return accessToken.isNotEmpty && refreshToken.isNotEmpty;
  }

  Future<void> deleteTokens() async {
    _accessToken = '';
    _refreshToken = '';

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_accessTokenKey);
    prefs.remove(_refreshTokenKey);
  }
}
