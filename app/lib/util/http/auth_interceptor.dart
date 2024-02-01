import 'dart:io';

import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/exception/index.dart';
import 'package:app/util/http/jwt_storage.dart';
import 'package:app/util/http/read_jwt_tokens.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptor implements Interceptor {
  final _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['MOBILE_APP_API_URL'] ?? '',
      contentType: 'application/json',
    ),
  );
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();
  final _jwtStorage = DependencyInjection.getIt<JwtStorage>();

  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] = 'Bearer ${await _jwtStorage.getAccessToken()}';

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == HttpStatus.unauthorized) {
      final response = await _dio.get(
        _mobileAppApi.refreshTokens(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await _jwtStorage.getRefreshToken()}',
          },
          validateStatus: (_) => true,
        ),
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final accessToken = readAccessTokenFromJsonBody(response.data);
          final refreshToken = readRefreshTokenFromJsonBody(response.data);

          await _jwtStorage.saveTokens(accessToken, refreshToken);
          error.requestOptions.headers['Authorization'] = 'Bearer ${await _jwtStorage.getAccessToken()}';

          return handler.resolve(await _dio.fetch(error.requestOptions));
        case HttpStatus.unauthorized:
          throw TokenExpiredApiException();
        case HttpStatus.forbidden:
          throw InvalidTokenApiException();
        default:
          throw UnknownApiException();
      }
    }

    return handler.next(error);
  }
}
