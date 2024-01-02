import 'package:app/shared/constant/index.dart';
import 'package:app/util/http/exception/api_exception.dart';

class UnknownApiException extends ApiException {
  UnknownApiException() : super(AppStrings.unknownError);
}
