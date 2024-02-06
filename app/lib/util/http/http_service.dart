import 'package:app/util/http/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio _configureBaseDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['MOBILE_APP_API_URL'] ?? '',
      contentType: 'application/json',
    ),
  );

  return dio;
}

Dio _configureAuthRequiredDio() {
  final dio = _configureBaseDio();
  dio.interceptors.add(AuthInterceptor());

  return dio;
}

class HttpService {
  final _dio = _configureAuthRequiredDio();

  Dio get authRequiredInstance => _dio;
  Dio get baseInstance => _configureBaseDio();
}
