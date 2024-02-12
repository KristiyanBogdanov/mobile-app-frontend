import 'package:app/api/location/index.dart';
import 'package:app/feature/location/add-device/device_type.dart';
import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class AddDeviceViewModel extends ChangeNotifier {
  final DeviceType _deviceType;
  final List<String> solarTrackerSerialNumbers;
  bool isScanSuccessful = false;
  Object deviceModel = Object();
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

    final response = _deviceType == DeviceType.solarTracker
        ? await _validateSTSerialNumber(code)
        : await _validateWSSerialNumber(code);

    if (serialNumberError == null && response != null) {
      isScanSuccessful = true;
      deviceModel = response;
      print(solarTrackerSerialNumbers);
    }

    notifyListeners();
  }

  Future<SolarTrackerModel?> _validateSTSerialNumber(String serialNumber) async {
    if (solarTrackerSerialNumbers.contains(serialNumber)) {
      serialNumberError = AppStrings.stSerialNumberAlreadyAdded;
      return null;
    }

    final response = await _locationRepository.validateSTSerialNumber(serialNumber);

    if (!response.isValid) {
      serialNumberError = AppStrings.invalidSTSerialNumber;
    } else if (response.isAdded != null && response.isAdded!) {
      serialNumberError = AppStrings.locationWithThisSTSerialNumberAlreadyAdded;
    } else if (response.isUsed != null && response.isUsed!) {
      serialNumberError = AppStrings.locationWithThisSTSerialNumberAlreadExists;
    } else {
      serialNumberError = null;
      return response.solarTracker!;
    }

    return null;
  }

  Future<String?> _validateWSSerialNumber(String serialNumber) async {
    final response = await _locationRepository.validateWSSerialNumber(serialNumber);

    if (!response.isValid) {
      serialNumberError = AppStrings.invalidWSSerialNumber;
    } else {
      serialNumberError = null;
      return serialNumber;
    }

    return null;
  }
}

// TODO: scan laptop qr code and check the exception