import 'package:app/shared/constant/index.dart';
import 'package:app/util/http/index.dart';

class EmailAlreadyUsedException extends ApiException {
  EmailAlreadyUsedException() : super(AppStrings.emailAlreadyUsed);
}