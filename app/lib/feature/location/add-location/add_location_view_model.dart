import 'package:app/api/location/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/feature/location/add-device/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AddLocationViewModel extends ChangeNotifier {
  String _name = '';
  String _location = 'nqma';
  String _capacity = '';
  final List<String> _solarTrackers = [];
  String? _weatherStation;
  String? _cctv;
  String? _nameError;
  String? _capacityError;
  String? _weatherStationError;
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

    _nameError = _validateName();
    _capacityError = _validateCapacity();

    if (_nameError != null || _capacityError != null) {
      notifyListeners();
      return;
    }

    final newLocationDto = NewLocationDto(
      _name,
      _location,
      int.parse(_capacity),
      _solarTrackers,
      _weatherStation,
      _cctv,
    );

    try {
      final location = await _userRepotitory.addNewLocation(newLocationDto);
      _navigationService.back(result: location);
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

  // String? validateLocation(String? location) {
  //   return _validateField(location, AppStrings.requiredLocationCoordinates);
  // }

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
    _nameError = null;
    _capacityError = null;
    _weatherStationError = null;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
  }

  void setLocation(String location) {
    _location = location;
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
      AddDeviceViewModel(deviceType: DeviceType.solarTracker, solarTrackerSerialNumbers: _solarTrackers),
    );

    if (response != null && response.confirmed) {
      _solarTrackers.add(response.data as String);
      notifyListeners();
    }
  }

  void removeSolarTracker(String serialNumber) {
    _solarTrackers.remove(serialNumber);
    notifyListeners();
  }

  Future<void> addWeatherStation() async {
    final response = await _showAddDeviceSheet(
      AddDeviceViewModel(deviceType: DeviceType.weatherStation),
    );

    if (response != null && response.confirmed) {
      _weatherStation = response.data as String;
      notifyListeners();
    }
  }

  void removeWeatherStation() {
    _weatherStation = null;
    notifyListeners();
  }

  bool get isAddWSButtonEnabled => _weatherStation == null;
  bool get isAddLocationButtonDisabled => solarTrackers.isEmpty;

  List<String> get solarTrackers => _solarTrackers;
  String? get weatherStation => _weatherStation;

  String? get nameError => _nameError;
  String? get capacityError => _capacityError;
  String? get weatherStationError => _weatherStationError;
}
