import 'package:app/shared/constant/index.dart';

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException() : message = AppStrings.userNotFound;

  @override
  String toString() => message;
}
