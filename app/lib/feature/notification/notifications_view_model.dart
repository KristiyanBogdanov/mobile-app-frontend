import 'package:app/api/hw-notification/index.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationsViewModel extends ChangeNotifier {
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  final _hwNotificationRepository = DependencyInjection.getIt<HwNotificationRepository>();
  final _globalState = DependencyInjection.getIt<GlobalState>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();

  void markAsSeen(String notificationId) {
    _globalState.markNotificationAsSeen(notificationId);
    _hwNotificationRepository.markAsSeen(notificationId);
    notifyListeners();
  }

  void onNotificationTap(HwNotificationModel notification) {
    markAsSeen(notification.id);

    if (notification.deviceType == DeviceType.solarTracker) {
      // TODO: implement this
      // final solarTracker = fetch
      // navigateToSolarTrackerPage
    } else if (notification.deviceType == DeviceType.weatherStation) {
      // TODO: implement this same as above
    }
  }

  void deleteNotification(HwNotificationModel notification) {
    _globalState.deleteNotification(notification);

    notifyListeners();
    _hwNotificationRepository.delete(notification.id);
  }

  List<HwNotificationModel> get notifications => _userRepository.userModel!.hwNotifications;
}
