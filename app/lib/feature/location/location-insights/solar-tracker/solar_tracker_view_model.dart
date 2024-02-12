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
  final SolarTrackerModel solarTracker;
  final LocationModel location;
  bool isLoading = false;
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  SolarTrackerViewModel({
    required this.solarTracker,
    required this.location,
  }) {
    _fetchSolarTrackerInsights(showError: false);
  }

  Future<void> _fetchSolarTrackerInsights({bool showError = true}) async {
    try {
      await _locationRepository.fetchSolarTrackerInsights(location.id, solarTracker.serialNumber);
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
      await _locationRepository.removeSolarTracker(location.id, solarTracker.serialNumber);
      location.solarTrackers.remove(solarTracker);
      location.capacity -= solarTracker.capacity;
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

  bool get isSolarTrackerInsightsAvailable =>
      _locationRepository.getSolarTrackerInsightsByLocationId(location.id, solarTracker.serialNumber) != null;
  SolarTrackerInsightsModel get solarTrackerInsightsModel =>
      _locationRepository.getSolarTrackerInsightsByLocationId(location.id, solarTracker.serialNumber)!;

  bool get isIrradianceSenssorActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.irradianceSensor;
  bool get isAccelometerActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.accelerometer;
  bool get isAzimuthMotorActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.azimuthMotor;
  bool get isElevationMotorActive =>
      solarTrackerInsightsModel.isActive && solarTrackerInsightsModel.sensorsStatus.elevationMotor;
}
