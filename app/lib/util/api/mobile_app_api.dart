class MobileAppApi {
  final _auth = '/auth';
  final _user = '/user';
  final _location = '/location';

  String getAuthLimits() {
    return '$_auth/limits';
  }

  String signUp() {
    return '$_auth/signup';
  }

  String signIn() {
    return '$_auth/signin';
  }

  String signOut() {
    return '$_auth/signout';
  }

  String refreshTokens() {
    return '$_auth/refresh';
  }

  String fetchUserData() {
    return '$_user/';
  }

  String addNewLocation() {
    return '$_user/add-location';
  }

  String addExistingLocation(String locationUuid) {
    return '$_user/add-existing-location/$locationUuid';
  }

  String removeLocation(String locationUuid) {
    return '$_user/location/$locationUuid';
  }

  String updateHwNotificationStatus(String notificationId) {
    return '$_user/hw-notification/$notificationId';
  }

  String deleteHwNotification(String notificationId) {
    return '$_user/hw-notification/$notificationId';
  }

  String getLocationLimits() {
    return '$_location/limits';
  }

  String validateSTSerialNumber(String serialNumber) {
    return '$_location/validate/st-serial-number/$serialNumber';
  }

  String validateWSSerialNumber(String serialNumber) {
    return '$_location/validate/ws-serial-number/$serialNumber';
  }

  String getLocationInsights(String locationId) {
    return '$_location/$locationId/insights';
  }

  String getWeatherStationInsights(String wsSerialNumber) {
    return '$_location/insights/weather-stations/$wsSerialNumber';
  }

  String addWeatherStation(String locationId, String wsSerialNumber) {
    return '$_location/$locationId/weather-stations/$wsSerialNumber';
  }

  String removeWeatherStation(String locationId) {
    return '$_location/$locationId/weather-stations';
  }

  String getSolarTrackerInsights(String locationId, String serialNumber) {
    return '$_location/$locationId/insights/solar-trackers/$serialNumber';
  }

  String addSolarTracker(String locationId, String serialNumber) {
    return '$_location/$locationId/solar-trackers/$serialNumber';
  }

  String removeSolarTracker(String locationId, String serialNumber) {
    return '$_location/$locationId/solar-trackers/$serialNumber';
  }
}
