import 'dart:convert';
import 'dart:io';

import 'package:app/api/location/dto/index.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';

class LocationService {
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<ValidateSerialNumberDto> _validateSerialNumber(String serialNumber, String endpoint) async {
    final response = await _httpService.get(endpoint);

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return ValidateSerialNumberDto.fromJson(jsonBody);
      case HttpStatus.unauthorized:
        throw UnauthorizedApiException();
      default:
        print(jsonBody);
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

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return LocationInsightsModel.fromJson(jsonBody);
      case HttpStatus.unauthorized:
        throw UnauthorizedApiException();
      default:
        throw UnknownApiException();
    }
  }
}
