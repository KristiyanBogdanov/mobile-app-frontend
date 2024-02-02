import 'package:app/api/location/index.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/location/location-insights/root/location_insights_view_model.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class LocationsViewModel extends ChangeNotifier {
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();

  void addNewLocation() async {
    final location = await _navigationService.navigateTo(RouteEnum.addLocation.name);

    if (location != null) {
      _userRepository.addLocation(location);
      notifyListeners();
    }
  }

  void navigateToLocation(LocationModel locationModel) {
    _navigationService.navigateTo(RouteEnum.locationInsights.name, arguments: LocationInsightsViewModel(locationModel));
  }

  List<LocationModel> get locations => _userRepository.userModel!.locations;
}
