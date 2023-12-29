import 'package:app/util/http/index.dart';

class BadRequestApiException extends ApiException {
  final List<ErrorCode> errorCodes;

  BadRequestApiException(Map<String, dynamic> jsonBody, String message)
      : errorCodes = ApiExceptionBody.fromJson(jsonBody)
            .errors
            .map((error) => error.code)
            .toList(),
        super(message);
}
