import 'package:app/shared/constant/index.dart';
import 'package:stacked_services/stacked_services.dart';

extension DialogServiceExtension on DialogService {
  Future<DialogResponse?> showUnauthorizedDialog() {
    return showDialog(
      title: AppStrings.unauthorizedError,
      description: AppStrings.anauthorizedDialogDescription,
      buttonTitle: AppStrings.anauthorizedDialogButton,
      barrierDismissible: false,
    );
  }

  // Future<DialogResponse?> showUnknownErrorDialog() {
  //   return showDialog(
  //     title: AppStrings.unknownError,
  //     description: AppStrings.unknownErrorDialogDescription,
  //     buttonTitle: AppStrings.unknownErrorDialogButton,
  //     barrierDismissible: false,
  //   );
  // }
}
