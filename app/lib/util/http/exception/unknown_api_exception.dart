import 'package:app/shared/constant/app_strings.dart';

class UnknownApiException implements Exception {
  final String message;

  UnknownApiException() : message = AppStrings.serverError;

  @override
  String toString() => message;
}
