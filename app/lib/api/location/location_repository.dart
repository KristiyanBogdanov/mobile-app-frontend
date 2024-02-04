import 'package:app/api/location/dto/index.dart';
import 'package:app/api/location/location_service.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class LocationRepository {
  LocationLimitsModel? limits;
  final Map<String, LocationInsightsModel> _locationInsights = {};
  final _locationService = DependencyInjection.getIt<LocationService>();

  Future<void> fetchLimits() async {
    limits = await _locationService.getLimits();
  }

  Future<ValidateSerialNumberDto> validateSTSerialNumber(String serialNumber) async {
    return await _locationService.validateSTSerialNumber(serialNumber);
  }

  Future<ValidateSerialNumberDto> validateWSSerialNumber(String serialNumber) async {
    return await _locationService.validateWSSerialNumber(serialNumber);
  }

  Future<LocationInsightsModel> fetchLocationInsights(String locationId) async {
    final insights = await _locationService.getLocationInsights(locationId);
    _locationInsights[locationId] = insights;

    return insights;
  }

  Future<WeatherStationInsightsModel> getWeatherStationInsights(String locationId, String wsSerialNumber) async {
    return await _locationService.getWeatherStationInsights(wsSerialNumber);
  }

  Future<void> addWeatherStation(String locationId, String wsSerialNumber) async {
    await _locationService.addWeatherStation(locationId, wsSerialNumber);
  }

  Future<void> removeWeatherStation(String locationId) async {
    await _locationService.removeWeatherStation(locationId);
  }

  void removeLocationInsights(String locationId) {
    _locationInsights.remove(locationId);
  }

  void clearData() {
    limits = null;
    _locationInsights.clear();
  }

  LocationInsightsModel? getLocationInsightsByLocationId(String locationId) => _locationInsights[locationId];
}
