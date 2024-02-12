import 'package:app/api/auth/auth_repository.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/util/common/clear_repositories_data.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/route_enum.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends ChangeNotifier {
  final _navigatorService = DependencyInjection.getIt<NavigationService>();
  final _authRepository = DependencyInjection.getIt<AuthRepository>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      clearRepositoriesData();
      _navigatorService.clearStackAndShow(RouteEnum.welcome.name);
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }
  }

  String get username => _userRepository.userModel!.username;
}
