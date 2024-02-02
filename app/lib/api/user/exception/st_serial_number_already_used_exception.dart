import 'package:app/shared/constant/app_strings.dart';

class STSerialNumberAlreadyUsedException implements Exception {
  final String message;

  STSerialNumberAlreadyUsedException() : message = AppStrings.stSerialNumberAlreadyUsedError;

  @override
  String toString() => message;
}
