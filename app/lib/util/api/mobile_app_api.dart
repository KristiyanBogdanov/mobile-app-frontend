class MobileAppApi {
  final _auth = '/auth';
  final _user = '/users';
  final _location = '/locations';

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
    return '$_user/locations';
  }

  String removeLocation(String locationId) {
    return '$_user/locations/$locationId';
  }

  String inviteUserToLocation() {
    return '$_user/invitations';
  }

  String respondToInvitation(String invitationId) {
    return '$_user/invitations/$invitationId';
  }

  String deleteHwNotification(String hwNotificationId) {
    return '$_user/hw-notifications/$hwNotificationId';
  }

  String getLocationLimits() {
    return '$_location/limits';
  }

  String getLocation(String locationId) {
    return '$_location/$locationId';
  }

  String validateSTSerialNumber(String serialNumber) {
    return '$_location/validate/solar-tracker/$serialNumber';
  }

  String validateWSSerialNumber(String serialNumber) {
    return '$_location/validate/weather-station/$serialNumber';
  }

  String getLocationInsights(String locationId) {
    return '$_location/$locationId/insights';
  }

  String getWeatherStationInsights(String locationId) {
    return '$_location/$locationId/insights/weather-station';
  }

  String addWeatherStation(String locationId, String wsSerialNumber) {
    return '$_location/$locationId/weather-station/$wsSerialNumber';
  }

  String removeWeatherStation(String locationId) {
    return '$_location/$locationId/weather-station';
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
