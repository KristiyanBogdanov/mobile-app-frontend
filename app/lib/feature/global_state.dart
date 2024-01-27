import 'package:app/api/hw-notification/index.dart';
import 'package:app/api/location/model/location_model.dart';
import 'package:app/api/user/index.dart';

class GlobalState {
  UserModel? _userModel;

  void addLocation(LocationModel locationModel) {
    _userModel!.locations.add(locationModel);
  }

  void markNotificationAsSeen(String notificationId) {
    final notification = _userModel!.hwNotifications.firstWhere((element) => element.id == notificationId);
    notification.status = NotificationStatus.seen;
  }

  void deleteNotification(HwNotificationModel notification) {
    _userModel!.hwNotifications.remove(notification);
  }

  void logout() {
    _userModel = null;
  }

  void setUser(UserModel userModel) {
    _userModel = userModel;
  }

  UserModel? get userModel => _userModel;
}
