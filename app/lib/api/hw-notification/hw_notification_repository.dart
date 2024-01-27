import 'package:app/api/hw-notification/hw_notification_service.dart';
import 'package:app/util/dependency_injection/index.dart';

class HwNotificationRepository {
  final _hwNotificationService = DependencyInjection.getIt<HwNotificationService>();

  Future<void> markAsSeen(String notificationId) async {
    await _hwNotificationService.markAsSeen(notificationId);
  }

  Future<void> delete(String notificationId) async {
    await _hwNotificationService.delete(notificationId);
  }
}