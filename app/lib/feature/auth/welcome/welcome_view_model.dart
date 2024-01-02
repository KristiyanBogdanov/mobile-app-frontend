import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class WelcomeViewModel extends ChangeNotifier {
  final _navigationService = DependencyInjection.getIt<NavigationService>();

  void navigateToSignIn() {
    _navigationService.navigateTo(RouteEnum.signin.name);
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(RouteEnum.signup.name);
  }
}