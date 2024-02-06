import 'package:app/api/location/index.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/location/add-device/index.dart';
import 'package:app/feature/location/location-insights/solar-tracker/solar_tracker_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/route_enum.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class LocationInsightsViewModel extends ChangeNotifier {
  final LocationModel locationModel;
  LocationInsightsModel? _locationInsightsModel;
  bool _isLoading = false;
  bool isWeatherStationLoading = false;
  final _bottomSheetService = DependencyInjection.getIt<BottomSheetService>();
  final _snackbarService = DependencyInjection.getIt<SnackbarService>();
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  LocationInsightsViewModel(this.locationModel) {
    _locationInsightsModel = _locationRepository.getLocationInsightsByLocationId(locationModel.id);
    _fetchLocationInsights();
  }

  Future<void> _fetchLocationInsights() async {
    try {
      _locationInsightsModel = await _locationRepository.fetchLocationInsights(locationModel.id);
      notifyListeners();
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      if (_locationInsightsModel == null) {
        showSnackbar(e.message);
      }
    }
  }

  Future<void> refreshWeatherStationInsights() async {
    try {
      _locationInsightsModel!.weatherStation = await _locationRepository.getWeatherStationInsights(
        locationModel.id,
        locationModel.weatherStation!,
      );
      notifyListeners();
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }
  }

  Future<void> addWeatherStation() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addDevice,
      isScrollControlled: true,
      data: AddDeviceViewModel(deviceType: DeviceType.weatherStation),
    );

    if (response == null || !response.confirmed) {
      return;
    }

    isWeatherStationLoading = true;
    notifyListeners();

    try {
      await _locationRepository.addWeatherStation(locationModel.id, response.data);
      _locationInsightsModel!.weatherStation = await _locationRepository.getWeatherStationInsights(
        locationModel.id,
        response.data,
      );
      locationModel.weatherStation = response.data;
    } on UnauthorizedDioException {
      handleUnauthorized();
      return;
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    }

    isWeatherStationLoading = false;
    notifyListeners();
  }

  Future<void> deleteWeatherStation() async {
    final response = await _dialogService.showBaseConfirmationDialog(
      title: AppStrings.deleteWeatherStationConfirmationTitle,
      description: AppStrings.deleteWeatherStationConfirmationDescription,
      confirmationTitle: AppStrings.deleteWeatherStationConfirmationButton,
    );

    if (response == null || !response.confirmed) {
      return;
    }

    isWeatherStationLoading = true;
    notifyListeners();

    try {
      await _locationRepository.removeWeatherStation(locationModel.id);
      _locationInsightsModel!.weatherStation = null;
      locationModel.weatherStation = null;
    } on UnauthorizedApiException {
      handleUnauthorized();
      return;
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    isWeatherStationLoading = false;
    notifyListeners();
  }

  Future<void> navigateToSolarTracker(String serialNumber, SolarTrackerInsightsModel solarTrackerInsightsModel) async {
    await _navigationService.navigateTo(
      RouteEnum.solarTracker.name,
      arguments: SolarTrackerViewModel(
        serialNumber: serialNumber,
        location: locationModel,
        solarTrackerInsightsModel: solarTrackerInsightsModel,
      ),
    );

    if (locationModel.solarTrackers.isEmpty) {
      _deleteLocation();
    }

    notifyListeners();
  }

  Future<void> addSolarTracker() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addDevice,
      isScrollControlled: true,
      data: AddDeviceViewModel(deviceType: DeviceType.solarTracker),
    );

    if (response == null || !response.confirmed) {
      return;
    }

    try {
      await _locationRepository.addSolarTracker(locationModel.id, response.data);
      final insights = await _locationRepository.fetchSolarTrackerInsights(locationModel.id, response.data);
      locationModel.solarTrackers.add(response.data);
      locationModel.capacity += insights.capacity;
      notifyListeners();
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }
  }

  Future<void> _deleteLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _userRepository.removeLocation(locationModel.id);
      _locationRepository.removeLocationInsights(locationModel.id);
      _navigationService.back();
      return;
    } on UnauthorizedApiException {
      handleUnauthorized();
      return;
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteLocation() async {
    final response = await _dialogService.showBaseConfirmationDialog(
      title: AppStrings.deleteLocationConfirmationTitle,
      description: AppStrings.deleteLocationConfirmationDescription,
      confirmationTitle: AppStrings.deleteLocationConfirmationButton,
    );

    if (response == null || !response.confirmed) {
      return;
    }

    _deleteLocation();
  }

  bool get isLoading => _locationInsightsModel == null || _isLoading;
  LocationInsightsModel get locationInsightsModel => _locationInsightsModel!;

  WeatherStationInsightsModel? get weatherStationInsightsModel => _locationInsightsModel!.weatherStation;
  bool get isWsTempSensorActive =>
      _locationInsightsModel!.weatherStation!.isActive &&
      _locationInsightsModel!.weatherStation!.sensorsStatus.temperatureSensor;
  bool get isWsAnemometerActive =>
      _locationInsightsModel!.weatherStation!.isActive &&
      _locationInsightsModel!.weatherStation!.sensorsStatus.anemometer;
}
