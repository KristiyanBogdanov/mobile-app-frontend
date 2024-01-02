import 'package:app/api/location/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/feature/location/add-device/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AddLocationViewModel extends ChangeNotifier {
  String _name = '';
  String _location = '';
  int _capacity = 0;
  final List<String> _solarTrackers = [];
  String? _weatherStation;
  String? _cctv;
  String? _nameError;
  String? _weatherStationError;
  final _formKey = GlobalKey<FormState>();
  final _navigatonService = DependencyInjection.getIt<NavigationService>();
  final _snackbarService = DependencyInjection.getIt<SnackbarService>();
  final _dialogService = DependencyInjection.getIt<DialogService>();
  final _userRepotitory = DependencyInjection.getIt<UserRepository>();
  final _globalState = DependencyInjection.getIt<GlobalState>();

  Future<LocationModel?> addNewLocation() async {
    _clearErrors();

    if (!_formKey.currentState!.validate()) {
      return null;
    }

    final newLocationDto = NewLocationDto(
      _name,
      _location,
      _capacity,
      _solarTrackers,
      _weatherStation,
      _cctv,
    );

    try {
      return await _userRepotitory.addNewLocation(newLocationDto);
    } on UnauthorizedApiException {
      final response = await _dialogService.showUnauthorizedDialog();

      if (response!.confirmed) {
        _globalState.logout();
        _navigatonService.clearStackAndShow(RouteEnum.signin.name);
      }
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

    return null;
  }

  String? _validateField(String? field, String errorMessage) {
    if (field == null || field.isEmpty) {
      return errorMessage;
    }

    return null;
  }

  String? validateName(String? name) {
    return _validateField(name, AppStrings.requiredLocationName);
  }

  String? validateLocation(String? location) {
    return _validateField(location, AppStrings.requiredLocationCoordinates);
  }

  String? validateCapacity(String? capacity) {
    final result = _validateField(capacity, AppStrings.requiredCapacity);

    if (result != null) {
      return result;
    }

    if (int.tryParse(capacity!) == null || int.parse(capacity) <= 0) {
      return AppStrings.invalidCapacity;
    }

    return null;
  }

  void _clearErrors() {
    _nameError = null;
    _weatherStationError = null;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
  }

  void setLocation(String location) {
    _location = location;
  }

  void setCapacity(int capacity) {
    _capacity = capacity;
  }

  Future<DialogResponse?> _showAddDeviceDialog(AddDeviceViewModel viewModel) async {
    return await _dialogService.showCustomDialog(
      barrierDismissible: false,
      variant: DialogType.addDevice,
      data: viewModel,
    );
  }

  Future<void> addSolarTracker() async {
    final response = await _showAddDeviceDialog(
      AddDeviceViewModel(
        deviceType: DeviceType.solarTracker,
        solarTrackerSerialNumbers: _solarTrackers,
      ),
    );

    if (response!.confirmed) {
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
    final response = await _showAddDeviceDialog(
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

  List<String> get solarTrackers => _solarTrackers;
  String? get weatherStation => _weatherStation;

  String? get nameError => _nameError;
  String? get weatherStationError => _weatherStationError;

  GlobalKey<FormState> get formKey => _formKey;
}
