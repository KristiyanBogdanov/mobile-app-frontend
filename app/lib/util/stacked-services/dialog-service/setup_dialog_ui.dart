import 'package:app/feature/location/location-insights/invite-user/invite_user_dialog.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/stacked-services/dialog-service/dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = DependencyInjection.getIt<DialogService>();

  final builders = {
    DialogType.inviteUser: (context, dialogRequest, completer) =>
        InviteUserDialog(request: dialogRequest, completer: completer)
  };

  dialogService.registerCustomDialogBuilders(builders);
}
