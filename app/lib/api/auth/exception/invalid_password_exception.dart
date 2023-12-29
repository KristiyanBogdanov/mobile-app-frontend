import 'package:app/shared/constant/index.dart';
import 'package:app/util/http/index.dart';

class InvalidPasswordException extends ApiException {
  InvalidPasswordException() : super(AppStrings.invalidPassword);
}