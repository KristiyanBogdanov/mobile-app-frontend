import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/http/exception/api_exception.dart';

class EmailAlreadyUsedException extends ApiException {
  EmailAlreadyUsedException() : super(AppStrings.emailAlreadyUsed);
}