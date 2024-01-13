import 'package:app/api/location/index.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/feature/location/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class LocationsViewModel extends ChangeNotifier {
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _globalState = DependencyInjection.getIt<GlobalState>();

  void addNewLocation() async {
    final location = await _navigationService.navigateTo(RouteEnum.addLocation.name);
    
    if (location != null) {
      _globalState.addLocation(location as LocationModel);
      notifyListeners();
    }
  }

  void navigateToLocation(LocationModel locationModel) {
    _navigationService.navigateTo(RouteEnum.locationInsights.name, arguments: LocationInsightsViewModel(locationModel));
  }

  List<LocationModel> get locations => _globalState.userModel!.locations;
}
