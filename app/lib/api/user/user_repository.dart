import 'package:app/api/hw-notification/index.dart';
import 'package:app/api/invitation/model/invitation_model.dart';
import 'package:app/api/location/index.dart';
import 'package:app/api/user/model/index.dart';
import 'package:app/api/user/user_service.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class UserRepository {
  UserModel? userModel;
  final _userService = DependencyInjection.getIt<UserService>();

  Future<void> fetchData() async {
    userModel = await _userService.fetchData();
  }

  Future<void> addNewLocation(NewLocationDto data) async {
    final location = await _userService.addNewLocation(data);
    userModel!.locations.add(location);
  }

  void updateLocationsList(LocationModel location) {
    final index = userModel!.locations.indexWhere((element) => element.id == location.id);

    if (index == -1) {
      userModel!.locations.add(location);
      return;
    }

    userModel!.locations[index].copyWith(location);
  }

  void removeLocationFromList(String locationId) {
    userModel!.locations.removeWhere((location) => location.id == locationId);
  }

  Future<void> deleteLocation(String locationId) async {
    await _userService.deleteLocation(locationId);
    removeLocationFromList(locationId);
  }

  void addHwNotification(HwNotificationModel notification) {
    if (userModel!.hwNotifications.contains(notification)) {
      return;
    }

    userModel!.hwNotifications.insert(0, notification);
  }

  void removeHwNotification(String hwNotificationId) {
    userModel!.hwNotifications.removeWhere((hwNotification) => hwNotification.id == hwNotificationId);
  }

  Future<void> deleteHwNotification(String notificationId) async {
    await _userService.deleteHwNotification(notificationId);
    removeHwNotification(notificationId);
  }

  Future<void> inviteUserToLocation(String locationId, String email) async {
    await _userService.inviteUserToLocation(locationId, email);
  }

  void addInvitation(InvitationModel invitation) {
    if (userModel!.invitations.contains(invitation)) {
      return;
    }

    userModel!.invitations.insert(0, invitation);
  }

  void removeInvitation(String invitationId) {
    userModel!.invitations.removeWhere((invitation) => invitation.id == invitationId);
  }

  Future<void> respondToInvitation(String invitationId, String locationId, bool accepted) async {
    await _userService.respondToInvitation(invitationId, locationId, accepted);
    removeInvitation(invitationId);
  }

  Future<void> removeUserFromLocation(String locationId, String userId) async {
    await _userService.removeUserFromLocation(locationId, userId);
  }

  void clearData() {
    userModel = null;
  }

  LocationModel getLocation(String locationId) {
    return userModel!.locations.firstWhere((location) => location.id == locationId);
  }
}
