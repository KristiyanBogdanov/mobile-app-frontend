import 'package:app/api/location/index.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/location/add-device/index.dart';
import 'package:app/feature/location/location-insights/invite-user/invite_user_view_model.dart';
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
  bool _isLoading = false;
  bool isWeatherStationLoading = false;
  final _bottomSheetService = DependencyInjection.getIt<BottomSheetService>();
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  LocationInsightsViewModel(this.locationModel) {
    _fetchLocationInsights();
  }

  Future<void> _fetchLocationInsights() async {
    try {
      await _locationRepository.fetchLocationInsights(locationModel.id);
      notifyListeners();
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      if (locationInsightsModel == null) {
        showSnackbar(e.message);
      }
    }
  }

  Future<void> refreshWeatherStationInsights() async {
    try {
      locationInsightsModel!.weatherStation = await _locationRepository.getWeatherStationInsights(locationModel.id);
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
      locationInsightsModel!.weatherStation = await _locationRepository.getWeatherStationInsights(locationModel.id);
      locationModel.weatherStation = response.data;
    } on UnauthorizedDioException {
      handleUnauthorized();
      return;
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
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
      locationInsightsModel!.weatherStation = null;
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

  Future<void> navigateToSolarTracker(
      SolarTrackerModel solarTracker, SolarTrackerInsightsModel solarTrackerInsightsModel) async {
    await _navigationService.navigateTo(
      RouteEnum.solarTracker.name,
      arguments: SolarTrackerViewModel(
        solarTracker: solarTracker,
        location: locationModel,
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
      data: AddDeviceViewModel(
        deviceType: DeviceType.solarTracker,
        solarTrackerSerialNumbers: locationModel.solarTrackers.map((st) => st.serialNumber).toList(),
      ),
    );

    if (response == null || !response.confirmed) {
      return;
    }

    try {
      final solarTracker = response.data as SolarTrackerModel;

      await _locationRepository.addSolarTracker(locationModel.id, solarTracker.serialNumber);
      await _locationRepository.fetchSolarTrackerInsights(locationModel.id, solarTracker.serialNumber);
      locationModel.solarTrackers.add(solarTracker);
      locationModel.capacity += solarTracker.capacity;
      notifyListeners();
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }
  }

  Future<void> inviteUser() async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.inviteUser,
      data: InviteUserViewModel(locationModel),
    );

    if (result != null || result?.confirmed == true) {
      await showSnackbar(AppStrings.userWasInvitedSuccessfully);
    }
  }

  Future<void> removeUser(String userId) async {
    try {
      await _userRepository.removeUserFromLocation(locationModel.id, userId);
      locationModel.sharedWith.removeWhere((user) => user.id == userId);
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
      await _userRepository.deleteLocation(locationModel.id);
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

  bool get isLocationAvailable => _userRepository.userModel!.locations.contains(locationModel);

  bool get isLoading => locationInsightsModel == null || _isLoading;
  LocationInsightsModel? get locationInsightsModel =>
      _locationRepository.getLocationInsightsByLocationId(locationModel.id);

  bool get isWeatherStationAvailable => locationModel.weatherStation != null;
  WeatherStationInsightsModel get weatherStationInsightsModel => locationInsightsModel!.weatherStation!;
  bool get isWsTempSensorActive =>
      locationInsightsModel!.weatherStation!.isActive &&
      locationInsightsModel!.weatherStation!.sensorsStatus.temperatureSensor;
  bool get isWsAnemometerActive =>
      locationInsightsModel!.weatherStation!.isActive &&
      locationInsightsModel!.weatherStation!.sensorsStatus.anemometer;
}
