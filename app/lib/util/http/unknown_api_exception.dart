import 'package:app/shared/constant/index.dart';
import 'package:app/util/http/api_exception.dart';

class UnknownApiException extends ApiException {
  UnknownApiException() : super(AppStrings.unknownError);
}
