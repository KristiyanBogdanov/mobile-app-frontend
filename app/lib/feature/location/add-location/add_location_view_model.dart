import 'package:app/api/location/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/feature/location/add-device/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/index.dart';
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

  Future<void> addNewLocation() async {
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
    } on UnauthorizedApiException {
      handleUnauthorizedApiException();
    } on STSerialNumberAlreadyUsedException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } on BadRequestApiException catch (e) {
      for (final errorCode in e.errorCodes) {
        switch (errorCode) {
          case ErrorCode.invalidLocationNameLength:
            _nameError = AppStrings.invalidLocationNameLength;
            notifyListeners();
            break;
          case ErrorCode.solarTrackersArrayMustContainAtLeastOneSerialNumber:
            _snackbarService.showSnackbar(message: AppStrings.invalidSTArraySize);
            break;
          case ErrorCode.invalidSTSerialNumber:
          case ErrorCode.invalidWSSerialNumber:
          default:
            _snackbarService.showSnackbar(message: e.message);
            break;
        }
      }
    } on UnknownApiException catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    }
  }

  String? _validateField(String? field, String errorMessage) {
    if (field == null || field.isEmpty) {
      return errorMessage;
    }

    return null;
  }

  String? _validateName() {
    return _validateField(_name, AppStrings.requiredLocationName);
  }

  // String? validateLocation(String? location) {
  //   return _validateField(location, AppStrings.requiredLocationCoordinates);
  // }

  String? _validateCapacity() {
    final result = _validateField(_capacity, AppStrings.requiredCapacity);

    if (result != null) {
      return result;
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
      AddDeviceViewModel(
        deviceType: DeviceType.solarTracker,
        solarTrackerSerialNumbers: _solarTrackers,
      ),
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

  bool isAddWSButtonEnabled() {
    return _weatherStation == null;
  }

  Future<void> addWeatherStation() async {
    final response = await _showAddDeviceSheet(
      AddDeviceViewModel(
        deviceType: DeviceType.weatherStation,
        solarTrackerSerialNumbers: _solarTrackers,
      ),
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

  List<String> get solarTrackers => _solarTrackers;
  String? get weatherStation => _weatherStation;

  String? get nameError => _nameError;
  String? get capacityError => _capacityError;
  String? get weatherStationError => _weatherStationError;
}
