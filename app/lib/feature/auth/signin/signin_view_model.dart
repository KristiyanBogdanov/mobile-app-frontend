import 'package:app/api/auth/index.dart';
import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/auth/auth_validator.dart';
import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends ChangeNotifier {
  bool isButtonEnabled = true;
  String _email = '';
  String _password = '';
  String? emailError;
  String? passwordError;
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final AuthValidator _authValidator;
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _authRepository = DependencyInjection.getIt<AuthRepository>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();
  final _firebaseApi = DependencyInjection.getIt<FirebaseApi>();

  SignInViewModel() {
    _authValidator = AuthValidator(_authRepository.limits!);
  }

  Future<void> signIn() async {
    _clearErrors();

    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      final fcmToken = await _firebaseApi.getDeviceToken();

      if (fcmToken == null) {
        showSnackbar(AppStrings.firebaseError);
        return;
      }

      isButtonEnabled = false;
      notifyListeners();

      _userRepository.userModel = await _authRepository.signIn(SignInDto(_email, _password, fcmToken));
      _navigationService.clearStackAndShow(RouteEnum.home.name);

      return;
    } on WrongCredentials catch (e) {
      passwordError = e.message;
      passwordController.clear();
    } on BadRequestApiException catch (e) {
      passwordController.clear();
      showSnackbar(e.message);
    } on UnknownApiException catch (e) {
      passwordController.clear();
      showSnackbar(e.message);
    }

    isButtonEnabled = true;
    notifyListeners();
  }

  String? validateEmail(String? email) {
    return _authValidator.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _authValidator.validatePassword(password);
  }

  void _clearErrors() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }
}
