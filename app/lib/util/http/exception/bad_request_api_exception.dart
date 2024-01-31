import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/http/index.dart';

class BadRequestApiException extends ApiException {
  BadRequestApiException() : super(AppStrings.badRequestError);
}
