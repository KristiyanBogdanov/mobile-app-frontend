import 'package:app/shared/constant/index.dart';
import 'package:app/util/http/exception/api_exception.dart';

class UnauthorizedApiException extends ApiException {
  UnauthorizedApiException() : super(AppStrings.unauthorizedError);
}