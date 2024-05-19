import 'package:app/util/http/auth_interceptor.dart';
import 'package:app/util/http/exception/index.dart';
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
  final _baseInstance = _configureBaseDio();
  final _authRequiredInstance = _configureAuthRequiredDio();

  void _handleDioException(DioException exception, [Map<int, Exception>? customExceptions]) {
    final statusCode = exception.response?.statusCode;

    if (customExceptions != null && customExceptions.containsKey(statusCode)) {
      throw customExceptions[statusCode]!;
    } else {
      throw UnknownApiException();
    }
  }

  Future<Response<dynamic>> get(
    String path, {
    Object? data,
    bool authRequired = true,
    Map<int, Exception>? customExceptions,
  }) async {
    final instance = authRequired ? _authRequiredInstance : _baseInstance;

    try {
      return await instance.get(path, data: data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      _handleDioException(e, customExceptions);
    }

    throw UnknownApiException();
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    bool authRequired = true,
    Map<int, Exception>? customExceptions,
  }) async {
    final instance = authRequired ? _authRequiredInstance : _baseInstance;

    try {
      return await instance.post(path, data: data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      _handleDioException(e, customExceptions);
    }

    throw UnknownApiException();
  }

  Future<Response<dynamic>> patch(
    String path, {
    Object? data,
    bool authRequired = true,
    Map<int, Exception>? customExceptions,
  }) async {
    final instance = authRequired ? _authRequiredInstance : _baseInstance;

    try {
      return await instance.patch(path, data: data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      _handleDioException(e, customExceptions);
    }

    throw UnknownApiException();
  }

  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    bool authRequired = true,
    Map<int, Exception>? customExceptions,
  }) async {
    final instance = authRequired ? _authRequiredInstance : _baseInstance;

    try {
      return await instance.delete(path, data: data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      _handleDioException(e, customExceptions);
    }

    throw UnknownApiException();
  }
}
