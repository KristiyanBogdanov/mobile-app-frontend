import 'dart:io';

import 'package:app/api/location/dto/index.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';

class LocationService {
  final _httpService = DependencyInjection.getIt<HttpService>().instance;
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<LocationLimitsModel> getLimits() async {
    final response = await _httpService.get(_mobileAppApi.getLocationLimits());

    switch (response.statusCode) {
      case HttpStatus.ok:
        return LocationLimitsModel.fromJson(response.data);
      default:
        throw UnknownApiException();
    }
  }

  Future<ValidateSerialNumberDto> _validateSerialNumber(String serialNumber, String endpoint) async {
    final response = await _httpService.get(endpoint);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return ValidateSerialNumberDto.fromJson(response.data);
      default:
        throw UnknownApiException();
    }
  }

  Future<ValidateSerialNumberDto> validateSTSerialNumber(String serialNumber) async {
    return await _validateSerialNumber(serialNumber, _mobileAppApi.validateSTSerialNumber(serialNumber));
  }

  Future<ValidateSerialNumberDto> validateWSSerialNumber(String serialNumber) async {
    return await _validateSerialNumber(serialNumber, _mobileAppApi.validateWSSerialNumber(serialNumber));
  }

  Future<LocationInsightsModel> getLocationInsights(String locationId) async {
    final response = await _httpService.get(_mobileAppApi.getLocationInsights(locationId));

    switch (response.statusCode) {
      case HttpStatus.ok:
        return LocationInsightsModel.fromJson(response.data);
      default:
        throw UnknownApiException();
    }
  }
}
