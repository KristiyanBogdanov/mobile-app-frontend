import 'package:app/shared/constant/index.dart';
import 'package:email_validator/email_validator.dart';

// TODO: think about singleton nature of this class
class AuthValidator {
  bool _fieldIsEmpty(String? field) {
    return field == null || field.isEmpty;
  }

  String? validateUsername(String? username) {
    if (_fieldIsEmpty(username)) {
      return AppStrings.requiredUsername;
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
