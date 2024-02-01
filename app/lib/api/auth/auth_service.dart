import 'dart:io';

import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/auth/exception/index.dart';
import 'package:app/api/auth/model/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:dio/dio.dart';

class AuthService {
  final _jwtStorage = DependencyInjection.getIt<JwtStorage>();
  final _httpService = DependencyInjection.getIt<HttpService>().instance;
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  void _saveTokensFromJsonBody(Map<String, dynamic> jsonBody) {
    final accessToken = readAccessTokenFromJsonBody(jsonBody);
    final refreshToken = readRefreshTokenFromJsonBody(jsonBody);

    _jwtStorage.saveTokens(accessToken, refreshToken);
  }

  Future<AuthLimitsModel> getLimits() async {
    final response = await _httpService.get(_mobileAppApi.getAuthLimits());

    switch (response.statusCode) {
      case HttpStatus.ok:
        return AuthLimitsModel.fromJson(response.data);
      default:
        throw UnknownApiException();
    }
  }

  Future<UserModel> signUp(SignUpDto data) async {
    final response = await _httpService.post(_mobileAppApi.signUp(), data: data);

    switch (response.statusCode) {
      case HttpStatus.created:
        _saveTokensFromJsonBody(response.data);
        return UserModel.fromJson(response.data);
      case HttpStatus.badRequest:
        throw BadRequestApiException();
      case HttpStatus.conflict:
        throw EmailAlreadyUsedException();
      default:
        throw UnknownApiException();
    }
  }

  Future<UserModel> signIn(SignInDto data) async {
    final response = await _httpService.post(
      _mobileAppApi.signIn(),
      data: data,
      options: Options(
        validateStatus: (_) => true,
      ),
    );

    switch (response.statusCode) {
      case HttpStatus.ok:
        _saveTokensFromJsonBody(response.data);
        return UserModel.fromJson(response.data);
      case HttpStatus.badRequest:
        throw BadRequestApiException();
      case HttpStatus.unauthorized:
        throw WrongCredentials();
      default:
        throw UnknownApiException();
    }
  }

  Future<void> signOut() async {
    final response = await _httpService.get(_mobileAppApi.signOut());

    switch (response.statusCode) {
      case HttpStatus.ok:
        _jwtStorage.deleteTokens();
        return;
      default:
        throw UnknownApiException();
    }
  }
}
