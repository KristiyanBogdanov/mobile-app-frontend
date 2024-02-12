import 'package:app/api/firebase/notification_type.dart';
import 'package:app/api/hw-notification/enum/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/hw_notification_model.g.dart';

@JsonSerializable()
class HwNotificationModel {
  final String id;
  final NotificationType notificationType;
  final String serialNumber;
  final DeviceType deviceType;
  final HwNotificationImportance importance;
  final String message;
  final String advice;
  final String timestamp;

  HwNotificationModel(
    this.id,
    this.notificationType,
    this.serialNumber,
    this.deviceType,
    this.importance,
    this.message,
    this.advice,
    this.timestamp,
  );

  factory HwNotificationModel.fromJson(Map<String, dynamic> json) => _$HwNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$HwNotificationModelToJson(this);

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
