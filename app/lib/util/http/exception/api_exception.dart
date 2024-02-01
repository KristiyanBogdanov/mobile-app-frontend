import 'package:app/util/http/error_codes.dart';

class ApiExceptionRecord {
  final String type;
  final ErrorCode code;
  final String message;

  ApiExceptionRecord(this.type, this.code, this.message);
}

class ApiExceptionBody {
  final List<ApiExceptionRecord> errors;

  ApiExceptionBody(this.errors);

  factory ApiExceptionBody.fromJson(Map<String, dynamic> json) {
    final dynamic errorBody = json['error'];
    final List<dynamic> errors = errorBody is List ? errorBody : [errorBody];

    return ApiExceptionBody(errors.map((error) {
      return ApiExceptionRecord(
        error['type'],
        ErrorCode.values.firstWhere((element) => element.code == error['code']),
        error['message'],
      );
    }).toList());
  }
}