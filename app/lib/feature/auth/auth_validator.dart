import 'package:app/api/auth/model/auth_limits_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:email_validator/email_validator.dart';

class AuthValidator {
  final AuthLimitsModel _authLimits;

  AuthValidator(this._authLimits);

  bool _fieldIsEmpty(String? field) {
    return field == null || field.isEmpty;
  }

  String? validateUsername(String? username) {
    if (_fieldIsEmpty(username)) {
      return AppStrings.requiredUsername;
    }

    if (username!.length < _authLimits.usernameMinLength || username.length > _authLimits.usernameMaxLength) {
      return AppStrings.invalidUsernameLength(_authLimits.usernameMinLength, _authLimits.usernameMaxLength);
    }

    return null;
  }

  String? validateEmail(String? email) {
    if (_fieldIsEmpty(email)) {
      return AppStrings.requiredEmail;
    }

    if (!EmailValidator.validate(email!)) {
      return AppStrings.invalidEmailFormat;
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (_fieldIsEmpty(password)) {
      return AppStrings.requiredPassword;
    }

    if (password!.length < _authLimits.passwordMinLength || password.length > _authLimits.passwordMaxLength) {
      return AppStrings.invalidPasswordLength(_authLimits.passwordMinLength, _authLimits.passwordMaxLength);
    }

    final numbers = RegExp(r'\d').allMatches(password).length;
    final lowerCase = RegExp(r'[a-z]').allMatches(password).length;
    final upperCase = RegExp(r'[A-Z]').allMatches(password).length;

    if (numbers < _authLimits.passwordMinNumbers ||
        lowerCase < _authLimits.passwordMinLowercase ||
        upperCase < _authLimits.passwordMinUppercase) {
      return AppStrings.invalidPassword(
        _authLimits.passwordMinNumbers,
        _authLimits.passwordMinLowercase,
        _authLimits.passwordMinUppercase,
      );
    }

    return null;
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (_fieldIsEmpty(confirmPassword)) {
      return AppStrings.requiredPassword;
    }

    if (password != confirmPassword) {
      return AppStrings.invalidConfirmPassword;
    }

    return null;
  }
}
