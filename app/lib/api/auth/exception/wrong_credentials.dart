import 'package:app/shared/constant/app_strings.dart';

class WrongCredentials implements Exception {
  final String message;

  WrongCredentials() : message = AppStrings.wrongCredentialsError;

  @override
  String toString() => message;
}
