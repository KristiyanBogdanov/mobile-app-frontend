import 'package:app/api/auth/index.dart';
import 'package:app/feature/auth/auth_validator.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _password = '';
  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  final _formKey = GlobalKey<FormState>();
  final _authRepository = DependencyInjection.getIt<AuthRepository>();
  final _globalState = DependencyInjection.getIt<GlobalState>();
  final _authValidator = DependencyInjection.getIt<AuthValidator>();

  Future<bool> signUp(Function showSnackbar) async {
    _clearErrors();

    if (!_formKey.currentState!.validate()) {
      return false;
    }

    try {
      final userModel = await _authRepository.signUp(SignUpDto(_username, _email, _password));
      _globalState.setUser(userModel);
      return true;
    } on EmailAlreadyUsedException catch (e) {
      _emailError = e.message;
      notifyListeners();
    } on BadRequestApiException catch (e) {
      for (final errorCode in e.errorCodes) {
        switch (errorCode) {
          case ErrorCode.tooShortUsername:
            _usernameError = AppStrings.tooShortUsername;
            notifyListeners();
            break;
          case ErrorCode.weakPassword:
            _passwordError = AppStrings.weakPassword;
            notifyListeners();
            break;
          default:
            showSnackbar(e.message);
            break;
        }
      }
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    return false;
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
