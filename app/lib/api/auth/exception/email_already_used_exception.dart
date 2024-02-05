import 'package:app/shared/constant/app_strings.dart';

class EmailAlreadyUsedException implements Exception {
  final String message;

  EmailAlreadyUsedException() : message = AppStrings.emailAlreadyUsedError;

  @override
  String toString() => message;
}
