import 'package:app/util/http/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio configureDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['MOBILE_APP_API_URL'] ?? '',
      contentType: 'application/json',
    ),
  );

  dio.interceptors.add(AuthInterceptor());

  return dio;
}

class HttpService {
  final _dio = configureDio();

  Dio get instance => _dio;
}