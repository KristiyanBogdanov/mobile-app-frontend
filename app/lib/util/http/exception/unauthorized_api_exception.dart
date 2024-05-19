import 'package:app/shared/constant/index.dart';

class UnauthorizedApiException implements Exception {
  final String message;

  UnauthorizedApiException() : message = AppStrings.unauthorizedError;

  @override
  String toString() => message;
}