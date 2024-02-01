import 'package:app/shared/constant/index.dart';
import 'package:app/util/http/exception/api_exception.dart';

class UnauthorizedApiException implements Exception {
  final String message;

  UnauthorizedApiException() : message = AppStrings.unauthorizedError;
}