import 'package:app/api/location/index.dart';
import 'package:app/feature/location/add-device/device_type.dart';
import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class AddDeviceViewModel extends ChangeNotifier {
  final DeviceType _deviceType;
  final List<String> solarTrackerSerialNumbers;
  bool isScanSuccessful = false;
  String serialNumber = '';
  String? serialNumberError;
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  AddDeviceViewModel({
    required DeviceType deviceType,
    this.solarTrackerSerialNumbers = const [],
  }) : _deviceType = deviceType;

  Future<void> addDevice(String? code) async {
    if (code == null || code.isEmpty) {
      return;
    }

    serialNumberError = _deviceType == DeviceType.solarTracker
        ? await _validateSTSerialNumber(code)
        : await _validateWSSerialNumber(code);

    if (serialNumberError == null) {
      isScanSuccessful = true;
      serialNumber = code;
    }

    notifyListeners();
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
}

// TODO: scan laptop qr code and check the exception