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

  String updateHwNotificationStatus(String notificationId) {
    return '$_user/hw-notification/$notificationId';
  }

  String deleteHwNotification(String notificationId) {
    return '$_user/hw-notification/$notificationId';
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
}
