import 'package:app/feature/location/add-device/add_device_dialog.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/stacked-services/dialog-service/dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = DependencyInjection.getIt<DialogService>();

  final builders = {
    DialogType.addDevice: (context, sheetRequest, completer) =>
        AddDeviceDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
