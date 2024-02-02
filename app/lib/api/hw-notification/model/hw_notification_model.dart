import 'package:app/api/hw-notification/enum/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/hw_notification_model.g.dart';

@JsonSerializable()
class HwNotificationModel {
  final String id;
  final HwNotificationType notificationType;
  final String serialNumber;
  final DeviceType deviceType;
  final HwNotificationImportance importance;
  final String message;
  final String timestamp;
  NotificationStatus status;

  HwNotificationModel(
    this.id,
    this.notificationType,
    this.serialNumber,
    this.deviceType,
    this.importance,
    this.message,
    this.timestamp,
    this.status,
  );

  factory HwNotificationModel.fromJson(Map<String, dynamic> json) => _$HwNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$HwNotificationModelToJson(this);

  String get parseTimestamp {
    final now = DateTime.now();
    final notificationTime = DateTime.parse(timestamp);
    final difference = now.difference(notificationTime);

    if (difference.inDays > 0) {
      return AppStrings.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return AppStrings.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return AppStrings.minutesAgo(difference.inMinutes);
    } else {
      return AppStrings.justNow;
    }
  }

  String get parseNotificationType {
    switch (notificationType) {
      case HwNotificationType.deviceState:
        return AppStrings.deviceState;
      case HwNotificationType.inactiveDevice:
        return AppStrings.inactiveDevice;
    }
  }

  String get parseImportance {
    switch (importance) {
      case HwNotificationImportance.information:
        return AppStrings.information;
      case HwNotificationImportance.warning:
        return AppStrings.warning;
      case HwNotificationImportance.critical:
        return AppStrings.critical;
    }
  }
}
