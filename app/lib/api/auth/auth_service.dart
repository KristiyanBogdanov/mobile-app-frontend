import 'dart:convert';
import 'dart:io';

import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/auth/exception/index.dart';
import 'package:app/api/auth/model/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';

class AuthService {
  final _jwtStorage = DependencyInjection.getIt<JwtStorage>();
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  String _readJwtFromJsonBody(Map<String, dynamic> jsonBody) {
    return jsonBody['accessToken'];
  }

  Future<AuthLimitsModel> getLimits() async {
    final response = await _httpService.get(_mobileAppApi.getAuthLimits());

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return AuthLimitsModel.fromJson(jsonBody);
      default:
        throw UnknownApiException();
    }
  }

  Future<UserModel> signUp(SignUpDto data) async {
    final response = await _httpService.post(
      _mobileAppApi.signUp(),
      data.toJson(),
    );

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.created:
        _jwtStorage.saveToken(_readJwtFromJsonBody(jsonBody));
        return UserModel.fromJson(jsonBody);
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
      data.toJson(),
    );

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        _jwtStorage.saveToken(_readJwtFromJsonBody(jsonBody));
        return UserModel.fromJson(jsonBody);
      case HttpStatus.badRequest:
        throw BadRequestApiException();
      case HttpStatus.unauthorized:
        throw WrongCredentials();
      default:
        throw UnknownApiException();
    }
  }
}
