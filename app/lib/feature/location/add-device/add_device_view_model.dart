import 'package:app/api/location/index.dart';
import 'package:app/feature/location/add-device/device_type.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:flutter/material.dart';

class AddDeviceViewModel extends ChangeNotifier {
  final DeviceType deviceType;
  final List<String> solarTrackerSerialNumbers;
  String _serialNumber = '';
  String? _serialNumberError;
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  AddDeviceViewModel({
    required this.deviceType,
    required this.solarTrackerSerialNumbers,
  });

  Future<String?> addDevice() async {
    _serialNumberError = await validateSerialNumber(_serialNumber);

    if (_serialNumberError != null) {
      notifyListeners();
      return null;
    }

    return _serialNumber;
  }

  Future<String?> validateSerialNumber(String? serialNumber) async {
    if (serialNumber == null || serialNumber.isEmpty) {
      return AppStrings.requiredSeialNumber;
    }

    return deviceType == DeviceType.solarTracker
        ? _validateSTSerialNumber(serialNumber)
        : _validateWSSerialNumber(serialNumber);
  }

  Future<String?> _validateSTSerialNumber(String serialNumber) async {
    if (solarTrackerSerialNumbers.contains(serialNumber)) {
      return AppStrings.stSerialNumberAlreadyAdded;
    }

    final validateSerialNumberDto = await _locationRepository.validateSTSerialNumber(serialNumber);

    if (!validateSerialNumberDto.isValid) {
      return AppStrings.invalidSTSerialNumber;
    } else if (validateSerialNumberDto.isAdded != null && validateSerialNumberDto.isAdded!) {
      return AppStrings.locationWithThisSTSerialNumberAlreadyAdded;
    } else if (validateSerialNumberDto.isUsed != null && validateSerialNumberDto.isUsed!) {
      return AppStrings.locationWithThisSTSerialNumberAlreadExists;
    } else {
      return null;
    }
  }

  Future<String?> _validateWSSerialNumber(String serialNumber) async {
    final validateSerialNumberDto = await _locationRepository.validateWSSerialNumber(serialNumber);

    if (!validateSerialNumberDto.isValid) {
      return AppStrings.invalidWSSerialNumber;
    } else {
      return null;
    }
  }

  void setSerialNumber(String serialNumber) {
    _serialNumber = serialNumber;
  }

  String? get serialNumberError => _serialNumberError;
}
