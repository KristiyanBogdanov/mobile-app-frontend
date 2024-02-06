import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/stacked-services/snackbar/snackbar_type.dart';
import 'package:stacked_services/stacked_services.dart';

void showSnackbar(String message, {SnackbarType type = SnackbarType.error}) {
  final snackbarService = DependencyInjection.getIt<SnackbarService>();

  if (!snackbarService.isSnackbarOpen) {
    snackbarService.showCustomSnackBar(
      variant: type,
      message: message,
    );
  }
}
