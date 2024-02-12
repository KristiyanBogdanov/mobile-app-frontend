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
      json['advice'] as String,
      json['timestamp'] as String,
    );

Map<String, dynamic> _$HwNotificationModelToJson(HwNotificationModel instance) => <String, dynamic>{
      'id': instance.id,
      'notificationType': _$NotificationTypeEnumMap[instance.notificationType]!,
      'serialNumber': instance.serialNumber,
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
      'importance': _$NotificationImportanceEnumMap[instance.importance]!,
      'message': instance.message,
      'advice': instance.advice,
      'timestamp': instance.timestamp,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.deviceStateReport: 'DEVICE_STATE_REPORT',
  NotificationType.inactiveDevice: 'INACTIVE_DEVICE',
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
