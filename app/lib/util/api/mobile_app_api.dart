import 'package:flutter_dotenv/flutter_dotenv.dart';

class MobileAppApi {
  final _auth = 'auth';
  final _user = 'user';
  final _location = 'location';
  final _baseUrl = dotenv.env['MOBILE_APP_API_URL'] ?? '';

  String _createApiEndpoint(String apiPath) {
    return '$_baseUrl/$apiPath';
  }

  String signUp() {
    return _createApiEndpoint('$_auth/signup');
  }

  String signIn() {
    return _createApiEndpoint('$_auth/signin');
  }

  String fetchUserData() {
    return _createApiEndpoint('$_user/');
  }

  String addNewLocation() {
    return _createApiEndpoint('$_user/add-location');
  }

  String addExistingLocation(String locationUuid) {
    return _createApiEndpoint('$_user/add-existing-location/$locationUuid');
  }

  String updateHwNotificationStatus(String notificationId) {
    return _createApiEndpoint('$_user/hw-notification/$notificationId');
  }

  String deleteHwNotification(String notificationId) {
    return _createApiEndpoint('$_user/hw-notification/$notificationId');
  }

  String validateSTSerialNumber(String serialNumber) {
    return _createApiEndpoint('$_location/validate/st-serial-number/$serialNumber');
  }

  String validateWSSerialNumber(String serialNumber) {
    return _createApiEndpoint('$_location/validate/ws-serial-number/$serialNumber');
  }

  String getLocationInsights(String locationId) {
    return _createApiEndpoint('$_location/$locationId/insights');
  }
}
