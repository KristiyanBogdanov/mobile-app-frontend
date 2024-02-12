import 'dart:io';

import 'package:app/api/location/exception/index.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';

class LocationService {
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<LocationLimitsModel> getLimits() async {
    final response = await _httpService.get(_mobileAppApi.getLocationLimits());
    return LocationLimitsModel.fromJson(response.data);
  }

  Future<LocationModel> getLocation(String locationId) async {
    final response = await _httpService.get(
      _mobileAppApi.getLocation(locationId),
      customExceptions: {
        HttpStatus.notFound: LocationNotFoundException(),
      },
    );

    return LocationModel.fromJson(response.data);
  }

  Future<ValidateSTSerialNumberModel> validateSTSerialNumber(String serialNumber) async {
    final response = await _httpService.get(_mobileAppApi.validateSTSerialNumber(serialNumber));
    return ValidateSTSerialNumberModel.fromJson(response.data);
  }

  Future<ValidateWSSerialNumberModel> validateWSSerialNumber(String serialNumber) async {
    final response = await _httpService.get(_mobileAppApi.validateWSSerialNumber(serialNumber));
    return ValidateWSSerialNumberModel.fromJson(response.data);
  }

  Future<LocationInsightsModel> getLocationInsights(String locationId) async {
    final response = await _httpService.get(_mobileAppApi.getLocationInsights(locationId));
    return LocationInsightsModel.fromJson(response.data);
  }

  Future<WeatherStationInsightsModel> getWeatherStationInsights(String locationId) async {
    final response = await _httpService.get(_mobileAppApi.getWeatherStationInsights(locationId));
    return WeatherStationInsightsModel.fromJson(response.data);
  }

  Future<void> addWeatherStation(String locationId, String wsSerialNumber) async {
    await _httpService.post(_mobileAppApi.addWeatherStation(locationId, wsSerialNumber));
  }

  Future<void> removeWeatherStation(String locationId) async {
    await _httpService.delete(_mobileAppApi.removeWeatherStation(locationId));
  }

  Future<SolarTrackerInsightsModel> getSolarTrackerInsights(String locationId, String serialNumber) async {
    final response = await _httpService.get(_mobileAppApi.getSolarTrackerInsights(locationId, serialNumber));
    return SolarTrackerInsightsModel.fromJson(response.data);
  }

  Future<void> addSolarTracker(String locationId, String serialNumber) async {
    await _httpService.post(_mobileAppApi.addSolarTracker(locationId, serialNumber));
  }

  Future<void> removeSolarTracker(String locationId, String serialNumber) async {
    await _httpService.delete(_mobileAppApi.removeSolarTracker(locationId, serialNumber));
  }
}
