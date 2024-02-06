import 'dart:io';

import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/auth/exception/index.dart';
import 'package:app/api/auth/model/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:dio/dio.dart';

class AuthService {
  final _jwtStorage = DependencyInjection.getIt<JwtStorage>();
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  void _saveTokensFromJsonBody(Map<String, dynamic> jsonBody) {
    final accessToken = readAccessTokenFromJsonBody(jsonBody);
    final refreshToken = readRefreshTokenFromJsonBody(jsonBody);

    _jwtStorage.saveTokens(accessToken, refreshToken);
  }

  Future<AuthLimitsModel> getLimits() async {
    try {
      final response = await _httpService.baseInstance.get(_mobileAppApi.getAuthLimits());
      return AuthLimitsModel.fromJson(response.data);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<UserModel> signUp(SignUpDto data) async {
    try {
      final response = await _httpService.baseInstance.post(_mobileAppApi.signUp(), data: data);
      _saveTokensFromJsonBody(response.data);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case HttpStatus.badRequest:
          throw BadRequestApiException();
        case HttpStatus.conflict:
          throw EmailAlreadyUsedException();
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<UserModel> signIn(SignInDto data) async {
    try {
      final response = await _httpService.baseInstance.post(_mobileAppApi.signIn(), data: data);
      _saveTokensFromJsonBody(response.data);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case HttpStatus.badRequest:
          throw BadRequestApiException();
        case HttpStatus.unauthorized:
          throw WrongCredentials();
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _httpService.authRequiredInstance.get(_mobileAppApi.signOut());
      _jwtStorage.deleteTokens();
      return;
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }
}
