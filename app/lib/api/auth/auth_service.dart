import 'dart:convert';
import 'dart:io';

import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/auth/exception/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';

class AuthService {
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  String _readJwtFromJsonBody(Map<String, dynamic> jsonBody) {
    return jsonBody['accessToken'];
  }

  Future<UserModel> signUp(SignUpDto data) async {
    final response = await _httpService.post(
      _mobileAppApi.signUp(),
      data.toJson(),
    );

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.created:
        _httpService.setAccessToken(_readJwtFromJsonBody(jsonBody));
        return UserModel.fromJson(jsonBody);
      case HttpStatus.badRequest:
        throw BadRequestApiException(jsonBody, AppStrings.signUpBadRequest);
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
        _httpService.setAccessToken(_readJwtFromJsonBody(jsonBody));
        return UserModel.fromJson(jsonBody);
      case HttpStatus.badRequest:
        throw BadRequestApiException(jsonBody, AppStrings.signInBadRequest);
      case HttpStatus.unauthorized:
        final ApiExceptionBody apiExceptionBody = ApiExceptionBody.fromJson(jsonBody);
        final ErrorCode errorCode = apiExceptionBody.errors.first.code;

        switch (errorCode) {
          case ErrorCode.invalidEmail:
            throw InvalidEmailException();
          case ErrorCode.invalidPassword:
            throw InvalidPasswordException();
          default:
            throw UnknownApiException();
        }
      default:
        throw UnknownApiException();
    }
  }
}