import 'package:app/feature/location/add-device/add_device_bottom_sheet.dart';
import 'package:app/feature/marketplace/filters/publication_filters_bottom_sheet.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/stacked-services/bottom-sheet-service/bottom_sheet_type.dart';
import 'package:stacked_services/stacked_services.dart';

void setupBottomSheetUi() {
  final bottomSheetService = DependencyInjection.getIt<BottomSheetService>();

  final builders = {
    BottomSheetType.addDevice: (context, sheetRequest, completer) => AddDeviceBottomSheet(
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.publicationFilters: (context, sheetRequest, completer) => PublicationFiltersBottomSheet(
          request: sheetRequest,
          completer: completer,
        ),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
