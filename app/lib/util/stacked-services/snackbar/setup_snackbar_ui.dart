import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/stacked-services/snackbar/snackbar_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final snackbarService = DependencyInjection.getIt<SnackbarService>();

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: DismissDirection.down,
      backgroundColor: AppStyle.secondaryColor2,
      textColor: AppStyle.textColor,
      instantInit: true,
    ),
  );
}
