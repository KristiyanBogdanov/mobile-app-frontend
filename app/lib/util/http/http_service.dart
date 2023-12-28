import 'dart:convert';

import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/jwt_storage.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final _jwtStorage = DependencyInjection.getIt<JwtStorage>();

  void setAccessToken(String accessToken) {
    _jwtStorage.saveToken(accessToken);
  }

  Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final jwt = await _jwtStorage.getToken();

    if (jwt.isNotEmpty) {
      headers['Authorization'] = 'Bearer $jwt';
    }

    return headers;
  }

  Future<http.Response> post(String url, Object body) async {
    return await http.post(
      Uri.parse(url),
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> get(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: await _getHeaders(),
    );
  }
}
