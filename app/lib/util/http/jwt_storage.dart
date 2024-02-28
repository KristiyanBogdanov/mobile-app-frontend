import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  String _accessToken = '';
  String _refreshToken = '';
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String> getAccessToken() async {
    if (_accessToken.isNotEmpty) {
      return _accessToken;
    }

    _accessToken = await _secureStorage.read(key: _accessTokenKey) ?? '';

    return _accessToken;
  }

  Future<String> getRefreshToken() async {
    if (_refreshToken.isNotEmpty) {
      return _refreshToken;
    }

    _refreshToken = await _secureStorage.read(key: _refreshTokenKey) ?? '';

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

    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
