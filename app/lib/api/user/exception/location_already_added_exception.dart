import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/http/exception/api_exception.dart';

class LocationAlreadyAddedException implements Exception {
  final String message;

  LocationAlreadyAddedException() : message = AppStrings.locationAlreadyAddedError;
}