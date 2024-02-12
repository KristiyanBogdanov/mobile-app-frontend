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

  Future<LocationModel> getLocation(String locationId) async {
    return await _locationService.getLocation(locationId);
  }

  Future<ValidateSTSerialNumberModel> validateSTSerialNumber(String serialNumber) async {
    return await _locationService.validateSTSerialNumber(serialNumber);
  }

  Future<ValidateWSSerialNumberModel> validateWSSerialNumber(String serialNumber) async {
    return await _locationService.validateWSSerialNumber(serialNumber);
  }

  Future<void> fetchLocationInsights(String locationId) async {
    final insights = await _locationService.getLocationInsights(locationId);
    _locationInsights[locationId] = insights;
  }

  Future<WeatherStationInsightsModel> getWeatherStationInsights(String locationId) async {
    return await _locationService.getWeatherStationInsights(locationId);
  }

  Future<void> addWeatherStation(String locationId, String wsSerialNumber) async {
    await _locationService.addWeatherStation(locationId, wsSerialNumber);
  }

  Future<void> removeWeatherStation(String locationId) async {
    await _locationService.removeWeatherStation(locationId);
  }

  Future<void> fetchSolarTrackerInsights(String locationId, String serialNumber) async {
    final insights = await _locationService.getSolarTrackerInsights(locationId, serialNumber);
    _locationInsights[locationId]!.solarTrackers[serialNumber] = insights;
  }

  Future<void> addSolarTracker(String locationId, String serialNumber) async {
    await _locationService.addSolarTracker(locationId, serialNumber);
  }

  Future<void> removeSolarTracker(String locationId, String serialNumber) async {
    await _locationService.removeSolarTracker(locationId, serialNumber);
    _locationInsights[locationId]!.solarTrackers.remove(serialNumber);
  }

  void removeLocationInsights(String locationId) {
    _locationInsights.remove(locationId);
  }

  void clearData() {
    limits = null;
    _locationInsights.clear();
  }

  LocationInsightsModel? getLocationInsightsByLocationId(String locationId) => _locationInsights[locationId];
  SolarTrackerInsightsModel? getSolarTrackerInsightsByLocationId(String locationId, String serialNumber) =>
      _locationInsights[locationId]?.solarTrackers[serialNumber];
}
