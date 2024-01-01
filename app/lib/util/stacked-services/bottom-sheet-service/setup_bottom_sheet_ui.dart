import 'package:app/feature/location/add-location/add_location_bottom_sheet.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/stacked-services/bottom-sheet-service/bottom_sheet_type.dart';
import 'package:stacked_services/stacked_services.dart';

void setupBottomSheetUi() {
  final bottomSheetService = DependencyInjection.getIt<BottomSheetService>();

  final builders = {
    BottomSheetType.addLocation: (context, sheetRequest, completer) =>
        AddLocationBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
