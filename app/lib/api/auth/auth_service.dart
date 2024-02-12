import 'dart:io';

import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/auth/exception/index.dart';
import 'package:app/api/auth/model/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';

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
    final response = await _httpService.get(
      _mobileAppApi.getAuthLimits(),
      authRequired: false,
    );

    return AuthLimitsModel.fromJson(response.data);
  }

  Future<UserModel> signUp(SignUpDto data) async {
    final response = await _httpService.post(
      _mobileAppApi.signUp(),
      data: data,
      authRequired: false,
      customExceptions: {
        HttpStatus.badRequest: BadRequestApiException(),
        HttpStatus.conflict: EmailAlreadyUsedException(),
      },
    );

    _saveTokensFromJsonBody(response.data);

    return UserModel.fromJson(response.data);
  }

  Future<UserModel> signIn(SignInDto data) async {
    final response = await _httpService.post(
      _mobileAppApi.signIn(),
      data: data,
      authRequired: false,
      customExceptions: {
        HttpStatus.badRequest: BadRequestApiException(),
        HttpStatus.unauthorized: WrongCredentials(),
      },
    );

    _saveTokensFromJsonBody(response.data);
    
    return UserModel.fromJson(response.data);
  }

  Future<void> signOut() async {
    await _httpService.get(_mobileAppApi.signOut());
    _jwtStorage.deleteTokens();
  }
}
