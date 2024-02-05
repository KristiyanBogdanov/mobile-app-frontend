import 'package:app/shared/constant/app_strings.dart';

class LocationAlreadyAddedException implements Exception {
  final String message;

  LocationAlreadyAddedException() : message = AppStrings.locationAlreadyAddedError;

  @override
  String toString() => message;
}
