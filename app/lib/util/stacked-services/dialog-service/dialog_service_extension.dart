import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:stacked_services/stacked_services.dart';

extension DialogServiceExtension on DialogService {
  Future<DialogResponse?> showUnauthorizedDialog() {
    return showDialog(
      title: AppStrings.unauthorizedError,
      description: AppStrings.unauthorizedDialogDescription,
      buttonTitle: AppStrings.unauthorizedDialogButton,
      buttonTitleColor: Colors.blue,
      barrierDismissible: false,
    );
  }

  Future<DialogResponse?> showBaseConfirmationDialog({
    required String title,
    required String description,
    required String confirmationTitle,
  }) {
    return showConfirmationDialog(
      title: title,
      description: description,
      confirmationTitle: confirmationTitle,
      confirmationTitleColor: Colors.blue,
      barrierDismissible: true,
    );
  }
}
