import 'package:app/api/location/index.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/location/add-device/index.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
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
    } on (InvalidTokenApiException, TokenExpiredApiException) {
      handleUnauthorized();
    } on UnknownApiException {
      // await _dialogService.showUnknownErrorDialog(); TODO: implement
    }
  }

  Future<void> refreshWeatherStationInsights() async {
    _locationInsightsModel!.weatherStation = await _locationRepository.getWeatherStationInsights(
      locationModel.id,
      locationModel.weatherStation!,
    );

    notifyListeners();
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
    } on (InvalidTokenApiException, TokenExpiredApiException) {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } finally {
      isWeatherStationLoading = false;
      notifyListeners();
    }
  }

// TODO: change ui and strings
  Future<void> deleteWeatherStation() async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete weather station',
      description: 'Are you sure you want to delete the weather station?',
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
    } on (InvalidTokenApiException, TokenExpiredApiException) {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } finally {
      isWeatherStationLoading = false;
      notifyListeners();
    }
  }

  // TODO: change ui and strings
  Future<void> deleteLocation() async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete location',
      description: 'Are you sure you want to delete the location?',
    );

    if (response == null || !response.confirmed) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _userRepository.removeLocation(locationModel.id);
      _locationRepository.removeLocationInsights(locationModel.id);
      _navigationService.back();
    } on (InvalidTokenApiException, TokenExpiredApiException) {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
