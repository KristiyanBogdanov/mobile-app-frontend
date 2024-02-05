import 'package:app/shared/constant/app_strings.dart';

class BadRequestApiException implements Exception {
  final String message;

  BadRequestApiException() : message = AppStrings.badRequestError;

  @override
  String toString() => message;
}
