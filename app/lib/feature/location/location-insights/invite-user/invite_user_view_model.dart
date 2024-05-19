import 'package:app/api/location/model/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class InviteUserViewModel extends ChangeNotifier {
  final LocationModel locationModel;
  String _email = '';
  String? emailError;
  bool isButtonDisabled = false;
  final _snackbarService = DependencyInjection.getIt<SnackbarService>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();

  InviteUserViewModel(this.locationModel);

  Future<bool> inviteUser() async {
    emailError = validateEmail(_email);

    if (emailError != null) {
      notifyListeners();
      return false;
    }

    if (!_userRepository.userModel!.locations.contains(locationModel)) {
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.error,
        message: AppStrings.inviteUserFailedBecauseOfLocationNotExists,
      );

      return false;
    }

    final isEmailValid = locationModel.sharedWith.map((user) => user.email).contains(_email) ||
        _userRepository.userModel!.email == _email;

    if (isEmailValid) {
      emailError = AppStrings.invalidEmail;
      notifyListeners();
      return false;
    }

    isButtonDisabled = true;
    notifyListeners();

    try {
      await _userRepository.inviteUserToLocation(locationModel.id, _email);
      return true;
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UserNotFoundException catch (e) {
      emailError = e.message;
    } on UnknownApiException catch (e) {
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.error,
        message: e.message,
      );
    }

    isButtonDisabled = false;
    notifyListeners();

    return false;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredEmail;
    }

    if (!EmailValidator.validate(value)) {
      return AppStrings.invalidEmailFormat;
    }

    return null;
  }

  void setEmail(String email) {
    _email = email;
  }
}
