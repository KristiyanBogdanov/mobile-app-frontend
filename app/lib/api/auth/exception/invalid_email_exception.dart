import 'package:app/shared/constant/index.dart';
import 'package:app/util/http/index.dart';

class InvalidEmailException extends ApiException {
  InvalidEmailException() : super(AppStrings.invalidEmail);
}