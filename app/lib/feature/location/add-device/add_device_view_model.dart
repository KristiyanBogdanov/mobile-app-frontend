import 'package:app/api/location/index.dart';
import 'package:app/feature/location/add-device/device_type.dart';
import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class AddDeviceViewModel extends ChangeNotifier {
  final DeviceType deviceType;
  final List<String> solarTrackerSerialNumbers;
  bool _isScanSuccessful = false;
  String _serialNumber = '';
  String? _serialNumberError;
  final _locationRepository = DependencyInjection.getIt<LocationRepository>();

  AddDeviceViewModel({
    required this.deviceType,
    this.solarTrackerSerialNumbers = const [],
  });

  Future<void> addDevice(String? serialNumber) async {
    if (serialNumber == null || serialNumber.isEmpty) {
      return;
    }

    _serialNumberError = deviceType == DeviceType.solarTracker
        ? await _validateSTSerialNumber(serialNumber)
        : await _validateWSSerialNumber(serialNumber);

    if (_serialNumberError == null) {
      _isScanSuccessful = true;
      _serialNumber = serialNumber;
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

  bool get isScanSuccessful => _isScanSuccessful;
  String get serialNumber => _serialNumber;
  String? get serialNumberError => _serialNumberError;
}

// TODO: scan laptop qr code and check the exception