// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hw_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HwNotificationModel _$HwNotificationModelFromJson(Map<String, dynamic> json) => HwNotificationModel(
      json['id'] as String,
      $enumDecode(_$NotificationTypeEnumMap, json['notificationType']),
      json['serialNumber'] as String,
      $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
      $enumDecode(_$NotificationImportanceEnumMap, json['importance']),
      json['message'] as String,
      json['timestamp'] as String,
      $enumDecode(_$NotificationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$HwNotificationModelToJson(HwNotificationModel instance) => <String, dynamic>{
      'id': instance.id,
      'notificationType': _$NotificationTypeEnumMap[instance.notificationType]!,
      'serialNumber': instance.serialNumber,
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
      'importance': _$NotificationImportanceEnumMap[instance.importance]!,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'status': _$NotificationStatusEnumMap[instance.status]!,
    };

const _$NotificationTypeEnumMap = {
  HwNotificationType.deviceState: 'DEVICE_STATE',
  HwNotificationType.inactiveDevice: 'INACTIVE_DEVICE',
};

const _$DeviceTypeEnumMap = {
  DeviceType.solarTracker: 'SOLAR_TRACKER',
  DeviceType.weatherStation: 'WEATHER_STATION',
};

const _$NotificationImportanceEnumMap = {
  HwNotificationImportance.information: 'INFORMATION',
  HwNotificationImportance.warning: 'WARNING',
  HwNotificationImportance.critical: 'CRITICAL',
};

const _$NotificationStatusEnumMap = {
  NotificationStatus.active: 'ACTIVE',
  NotificationStatus.seen: 'SEEN',
};
