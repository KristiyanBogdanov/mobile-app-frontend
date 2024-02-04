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
  String _name = '';
  String _capacity = '';
  final List<String> solarTrackers = [];
  String? weatherStation;
  String? cctv;
  String? nameError;
  String? capacityError;
  String? weatherStationError;
  final _snackbarService = DependencyInjection.getIt<SnackbarService>();
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
    } catch (_) {
      _snackbarService.showSnackbar(message: AppStrings.serverError);
      return false;
    }
  }

  Future<void> addNewLocation() async {
    if (!await checkLocationLimits()) {
      return;
    }

    _clearErrors();

    nameError = _validateName();
    capacityError = _validateCapacity();

    if (nameError != null || capacityError != null) {
      notifyListeners();
      return;
    }

    final newLocationDto = NewLocationDto(
      _name,
      int.parse(_capacity),
      solarTrackers,
      weatherStation,
      cctv,
    );

    try {
      await _userRepotitory.addNewLocation(newLocationDto);
      _navigationService.back(result: true);
    } on (InvalidTokenApiException, TokenExpiredApiException) {
      handleUnauthorized();
    } on STSerialNumberAlreadyUsedException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } on BadRequestApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    }
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

  String? _validateCapacity() {
    if (_fieldIsEmpty(_capacity)) {
      return AppStrings.requiredCapacity;
    }

    if (int.tryParse(_capacity) == null || int.parse(_capacity) <= 0) {
      return AppStrings.invalidCapacity;
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
  }

  void setCapacity(String capacity) {
    _capacity = capacity;
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
  bool get isAddLocationButtonDisabled => solarTrackers.isEmpty;
}
