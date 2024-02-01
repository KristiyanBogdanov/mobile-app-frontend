import 'package:app/api/auth/auth_repository.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class WelcomeViewModel extends ChangeNotifier {
  final _authRepository = DependencyInjection.getIt<AuthRepository>();
  final _snackbarService = DependencyInjection.getIt<SnackbarService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();

  WelcomeViewModel() {
    _authRepository.fetchLimits();
  }

  Future<bool> checkAuthLimits() async {
    if (_authRepository.limits != null) {
      return true;
    }

    try {
      await _authRepository.fetchLimits();
      return true;
    } catch (_) {
      _snackbarService.showSnackbar(message: AppStrings.unknownError);
      return false;
    }
  }

  Future<void> navigateToSignIn() async {
    if (await checkAuthLimits()) {
      _navigationService.navigateTo(RouteEnum.signin.name);
    }
  }

  Future<void> navigateToSignUp() async {
    if (await checkAuthLimits()) {
      _navigationService.navigateTo(RouteEnum.signup.name);
    }
  }
}
