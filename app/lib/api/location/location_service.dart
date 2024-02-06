import 'package:app/api/location/dto/index.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:dio/dio.dart';

class LocationService {
  final _httpService = DependencyInjection.getIt<HttpService>().authRequiredInstance;
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<LocationLimitsModel> getLimits() async {
    try {
      final response = await _httpService.get(_mobileAppApi.getLocationLimits());
      return LocationLimitsModel.fromJson(response.data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<ValidateSerialNumberDto> _validateSerialNumber(String serialNumber, String endpoint) async {
    try {
      final response = await _httpService.get(endpoint);
      return ValidateSerialNumberDto.fromJson(response.data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<ValidateSerialNumberDto> validateSTSerialNumber(String serialNumber) async {
    return await _validateSerialNumber(serialNumber, _mobileAppApi.validateSTSerialNumber(serialNumber));
  }

  Future<ValidateSerialNumberDto> validateWSSerialNumber(String serialNumber) async {
    return await _validateSerialNumber(serialNumber, _mobileAppApi.validateWSSerialNumber(serialNumber));
  }

  Future<LocationInsightsModel> getLocationInsights(String locationId) async {
    try {
      final response = await _httpService.get(_mobileAppApi.getLocationInsights(locationId));
      return LocationInsightsModel.fromJson(response.data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<WeatherStationInsightsModel> getWeatherStationInsights(String wsSerialNumber) async {
    try {
      final response = await _httpService.get(_mobileAppApi.getWeatherStationInsights(wsSerialNumber));
      return WeatherStationInsightsModel.fromJson(response.data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<void> addWeatherStation(String locationId, String wsSerialNumber) async {
    try {
      await _httpService.post(_mobileAppApi.addWeatherStation(locationId, wsSerialNumber));
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<void> removeWeatherStation(String locationId) async {
    try {
      await _httpService.delete(_mobileAppApi.removeWeatherStation(locationId));
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<SolarTrackerInsightsModel> getSolarTrackerInsights(String locationId, String serialNumber) async {
    try {
      final response = await _httpService.get(_mobileAppApi.getSolarTrackerInsights(locationId, serialNumber));
      return SolarTrackerInsightsModel.fromJson(response.data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<void> addSolarTracker(String locationId, String serialNumber) async {
    try {
      await _httpService.post(_mobileAppApi.addSolarTracker(locationId, serialNumber));
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<void> removeSolarTracker(String locationId, String serialNumber) async {
    try {
      await _httpService.delete(_mobileAppApi.removeSolarTracker(locationId, serialNumber));
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }
}
