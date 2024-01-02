import 'package:app/api/auth/index.dart';
import 'package:app/feature/auth/auth_validator.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  final _formKey = GlobalKey<FormState>();
  final _authRepository = DependencyInjection.getIt<AuthRepository>();
  final _globalState = DependencyInjection.getIt<GlobalState>();
  final _authValidator = DependencyInjection.getIt<AuthValidator>();

  Future<bool> signIn(Function showSnackbar) async {
    _clearErrors();

    if (!_formKey.currentState!.validate()) {
      return false;
    }

    try {
      final userModel = await _authRepository.signIn(SignInDto(_email, _password));
      _globalState.setUser(userModel);
      return true;
    } on InvalidEmailException catch (e) {
      _emailError = e.message;
      notifyListeners();
    } on InvalidPasswordException catch (e) {
      _passwordError = e.message;
      notifyListeners();
    } on BadRequestApiException catch (e) {
      showSnackbar(e.message);
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    return false;
  }

  String? validateEmail(String? email) {
    return _authValidator.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _authValidator.validatePassword(password);
  }

  void _clearErrors() {
    _emailError = null;
    _passwordError = null;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  GlobalKey<FormState> get formKey => _formKey;
}