import 'package:app/api/location/dto/index.dart';
import 'package:app/api/location/location_service.dart';
import 'package:app/api/location/model/index.dart';
import 'package:app/util/dependency_injection/index.dart';

class LocationRepository {
  final _locationService = DependencyInjection.getIt<LocationService>();

  Future<ValidateSerialNumberDto> validateSTSerialNumber(String serialNumber) async {
    return await _locationService.validateSTSerialNumber(serialNumber);
  }

  Future<ValidateSerialNumberDto> validateWSSerialNumber(String serialNumber) async {
    return await _locationService.validateWSSerialNumber(serialNumber);
  }

  Future<LocationInsightsModel> getLocationInsights(String locationId) async {
    return await _locationService.getLocationInsights(locationId);
  }
}
