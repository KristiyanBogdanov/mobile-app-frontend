import 'package:app/api/auth/index.dart';
import 'package:app/feature/auth/auth_validator.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  final _formKey = GlobalKey<FormState>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _snackbarService = DependencyInjection.getIt<SnackbarService>();
  final _authRepository = DependencyInjection.getIt<AuthRepository>();
  final _globalState = DependencyInjection.getIt<GlobalState>();
  final _authValidator = DependencyInjection.getIt<AuthValidator>();

  Future<void> signIn() async {
    _clearErrors();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final userModel = await _authRepository.signIn(SignInDto(_email, _password));
      _globalState.setUser(userModel);
      _navigationService.clearStackAndShow(RouteEnum.home.name);
    } on InvalidEmailException catch (e) {
      _emailError = e.message;
      notifyListeners();
    } on InvalidPasswordException catch (e) {
      _passwordError = e.message;
      notifyListeners();
    } on BadRequestApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    }
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
