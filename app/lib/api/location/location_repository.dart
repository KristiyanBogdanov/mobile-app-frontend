import 'package:app/api/location/dto/index.dart';
import 'package:app/api/location/location_service.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class LocationRepository {
  LocationLimitsModel? _limits;
  final _locationService = DependencyInjection.getIt<LocationService>();

  Future<void> fetchLimits() async {
    _limits = await _locationService.getLimits();
  }

  Future<ValidateSerialNumberDto> validateSTSerialNumber(String serialNumber) async {
    return await _locationService.validateSTSerialNumber(serialNumber);
  }

  Future<ValidateSerialNumberDto> validateWSSerialNumber(String serialNumber) async {
    return await _locationService.validateWSSerialNumber(serialNumber);
  }

  Future<LocationInsightsModel> getLocationInsights(String locationId) async {
    return await _locationService.getLocationInsights(locationId);
  }

  LocationLimitsModel? get limits => _limits;
}
