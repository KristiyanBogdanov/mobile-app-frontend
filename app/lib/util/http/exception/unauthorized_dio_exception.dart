import 'package:dio/dio.dart';

class UnauthorizedDioException extends DioException {
  UnauthorizedDioException({required super.requestOptions});
}
