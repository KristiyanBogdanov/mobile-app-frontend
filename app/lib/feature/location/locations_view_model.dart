import 'package:app/api/location/index.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class LocationsViewModel extends ChangeNotifier {
  final _bottomSheetService = DependencyInjection.getIt<BottomSheetService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _globalState = DependencyInjection.getIt<GlobalState>();

  void addNewLocation() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addLocation,
    );

    if (response != null && response.confirmed) {
      final locationModel = response.data as LocationModel;
      _globalState.addLocation(locationModel);
      notifyListeners();
    }
  }

  void navigateToLocation(LocationModel locationModel) {
    _navigationService.navigateTo(RouteEnum.locationInsights.name, arguments: locationModel);
  }

  List<LocationModel> get locations => _globalState.userModel!.locations;
}
