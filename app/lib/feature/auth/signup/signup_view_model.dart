import 'package:app/api/auth/index.dart';
import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/auth/auth_validator.dart';
import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _password = '';
  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  final _formKey = GlobalKey<FormState>();
  late final AuthValidator _authValidator;
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _snackbarService = DependencyInjection.getIt<SnackbarService>();
  final _authRepository = DependencyInjection.getIt<AuthRepository>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();
  final _firebaseApi = DependencyInjection.getIt<FirebaseApi>();

  SignUpViewModel() {
    _authValidator = AuthValidator(_authRepository.limits!);
  }

  Future<void> signUp() async {
    _clearErrors();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final fcmToken = await _firebaseApi.getDeviceToken();

      if (fcmToken == null) {
        _snackbarService.showSnackbar(message: AppStrings.serverError);
        return;
      }

      _userRepository.setUser = await _authRepository.signUp(SignUpDto(_username.trim(), _email, _password, fcmToken));
      _navigationService.clearStackAndShow(RouteEnum.home.name);
    } on EmailAlreadyUsedException catch (e) {
      _emailError = e.message;
      notifyListeners();
    } on BadRequestApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    }
  }

  String? validateUsername(String? username) {
    return _authValidator.validateUsername(username);
  }

  String? validateEmail(String? email) {
    return _authValidator.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _authValidator.validatePassword(password);
  }

  String? validateConfirmPassword(String? confirmPassword) {
    return _authValidator.validateConfirmPassword(_password, confirmPassword);
  }

  void _clearErrors() {
    _usernameError = null;
    _emailError = null;
    _passwordError = null;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? get usernameError => _usernameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  GlobalKey<FormState> get formKey => _formKey;
}
