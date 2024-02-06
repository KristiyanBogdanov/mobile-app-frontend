import 'package:app/api/location/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/feature/location/add-device/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/common/handle_unauthorized.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AddLocationViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _name = '';
  final List<String> solarTrackers = [];
  String? weatherStation;
  String? cctv;
  String? nameError;
  String? capacityError;
  String? weatherStationError;
  final _bottomSheetService = DependencyInjection.getIt<BottomSheetService>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _userRepotitory = DependencyInjection.getIt<UserRepository>();
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  AddLocationViewModel() {
    if (_locationRepository.limits == null) {
      _locationRepository.fetchLimits();
    }
  }

  Future<bool> checkLocationLimits() async {
    if (_locationRepository.limits != null) {
      return true;
    }

    try {
      await _locationRepository.fetchLimits();
      return true;
    } on UnauthorizedApiException {
      handleUnauthorized();
      return false;
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
      return false;
    }
  }

  Future<void> addNewLocation() async {
    if (!await checkLocationLimits()) {
      return;
    }

    _clearErrors();

    nameError = _validateName();

    if (nameError != null || capacityError != null) {
      notifyListeners();
      return;
    }

    final newLocationDto = NewLocationDto(
      _name,
      solarTrackers,
      weatherStation,
      cctv,
    );

    _isLoading = true;
    notifyListeners();

    try {
      await _userRepotitory.addNewLocation(newLocationDto);
      _navigationService.back(result: true);
      return;
    } on UnauthorizedApiException {
      handleUnauthorized();
    } on STSerialNumberAlreadyUsedException catch (e) {
      showSnackbar(e.message);
    } on BadRequestApiException catch (e) {
      showSnackbar(e.message);
    } on UnknownApiException catch (e) {
      showSnackbar(e.message);
    }

    _isLoading = false;
    notifyListeners();
  }

  bool _fieldIsEmpty(String? field) {
    return field == null || field.isEmpty;
  }

  String? _validateName() {
    if (_fieldIsEmpty(_name)) {
      return AppStrings.requiredLocationName;
    }

    if (_name.length < _locationRepository.limits!.nameMinLength ||
        _name.length > _locationRepository.limits!.nameMaxLength) {
      return AppStrings.invalidLocationNameLength(
        _locationRepository.limits!.nameMinLength,
        _locationRepository.limits!.nameMaxLength,
      );
    }

    return null;
  }

  void _clearErrors() {
    nameError = null;
    capacityError = null;
    weatherStationError = null;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  Future<SheetResponse?> _showAddDeviceSheet(AddDeviceViewModel viewModel) async {
    return await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addDevice,
      isScrollControlled: true,
      data: viewModel,
    );
  }

  Future<void> addSolarTracker() async {
    final response = await _showAddDeviceSheet(
      AddDeviceViewModel(deviceType: DeviceType.solarTracker, solarTrackerSerialNumbers: solarTrackers),
    );

    if (response != null && response.confirmed) {
      solarTrackers.add(response.data as String);
      notifyListeners();
    }
  }

  void removeSolarTracker(String serialNumber) {
    solarTrackers.remove(serialNumber);
    notifyListeners();
  }

  Future<void> addWeatherStation() async {
    final response = await _showAddDeviceSheet(
      AddDeviceViewModel(deviceType: DeviceType.weatherStation),
    );

    if (response != null && response.confirmed) {
      weatherStation = response.data;
      notifyListeners();
    }
  }

  void removeWeatherStation() {
    weatherStation = null;
    notifyListeners();
  }

  bool get isAddWSButtonEnabled => weatherStation == null;
  bool get isAddLocationButtonDisabled => solarTrackers.isEmpty || _isLoading || _name.isEmpty;
}
