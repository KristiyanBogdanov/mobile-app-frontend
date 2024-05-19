import 'package:app/api/hw-notification/index.dart';
import 'package:app/api/invitation/model/invitation_model.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:flutter/widgets.dart';

class NotificationsViewModel extends ChangeNotifier {
  final _userRepository = DependencyInjection.getIt<UserRepository>();

  Future<void> deleteNotification(HwNotificationModel notification) async {
    await _userRepository.deleteHwNotification(notification.id);
    notifyListeners();
  }

  Future<void> respondToInvitation(InvitationModel invitation, bool accepted) async {
    await _userRepository.respondToInvitation(invitation.id, invitation.locationId, accepted);
    notifyListeners();
  }

  Future<void> acceptInvitation(InvitationModel invitation) async {
    await respondToInvitation(invitation, true);
  }

  Future<void> rejectInvitation(InvitationModel invitation) async {
    await respondToInvitation(invitation, false);
  }

  List<dynamic> get notifications => [
        ..._userRepository.userModel!.invitations,
        ..._userRepository.userModel!.hwNotifications,
      ];
}
