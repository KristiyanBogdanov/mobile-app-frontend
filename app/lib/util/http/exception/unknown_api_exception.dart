import 'package:app/shared/constant/app_strings.dart';

class UnknownApiException implements Exception {
  final String message;

  UnknownApiException() : message = AppStrings.unknownError;

  @override
  String toString() => message;
}
