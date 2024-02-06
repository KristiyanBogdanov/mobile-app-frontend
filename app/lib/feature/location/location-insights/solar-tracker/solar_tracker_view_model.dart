import 'package:app/api/location/location_repository.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SolarTrackerViewModel extends ChangeNotifier {
  final String serialNumber;
  final LocationModel location;
  SolarTrackerInsightsModel solarTrackerInsightsModel;
  bool isLoading = false;
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  SolarTrackerViewModel({
    required this.serialNumber,
    required this.location,
    required this.solarTrackerInsightsModel,
  }) {
    _fetchSolarTrackerInsights(showError: false);
  }

  Future<void> _fetchSolarTrackerInsights({bool showError = true}) async {
    try {
      solarTrackerInsightsModel = await _locationRepository.fetchSolarTrackerInsights(location.id, serialNumber);
      notifyListeners();
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      if (showError) {
        showSnackbar(e.message);
      }
    }
  }

  Future<void> refreshSolarTrackerInsights() async {
    await _fetchSolarTrackerInsights();
  }

  Future<void> removeSolarTracker() async {
    final response = await _dialogService.showBaseConfirmationDialog(
      title: AppStrings.deleteSolarTrackerConfirmationTitle,
      description: AppStrings.deleteSolarTrackerConfirmationDescription,
      confirmationTitle: AppStrings.deleteSolarTrackerConfirmationButton,
    );

    if (response == null || !response.confirmed) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _locationRepository.removeSolarTracker(location.id, serialNumber);
      location.solarTrackers.remove(serialNumber);
      location.capacity -= solarTrackerInsightsModel.capacity;
      _navigationService.back();
      return;
    } on UnauthorizedApiException {
      handleUnauthorized();
      return;
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    isLoading = false;
    notifyListeners();
  }

  bool get isIrradianceSenssorActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.irradianceSensor;
  bool get isAccelometerActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.accelerometer;
  bool get isAzimuthMotorActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.azimuthMotor;
  bool get isElevationMotorActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.elevationMotor;
}
