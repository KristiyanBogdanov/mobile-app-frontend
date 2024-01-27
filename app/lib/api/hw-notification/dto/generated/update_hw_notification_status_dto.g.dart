// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../update_hw_notification_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateHwNotificationStatusDto _$UpdateHwNotificationStatusDtoFromJson(Map<String, dynamic> json) =>
    UpdateHwNotificationStatusDto(
      $enumDecode(_$NotificationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UpdateHwNotificationStatusDtoToJson(UpdateHwNotificationStatusDto instance) => <String, dynamic>{
      'status': _$NotificationStatusEnumMap[instance.status]!,
    };

const _$NotificationStatusEnumMap = {
  NotificationStatus.active: 'ACTIVE',
  NotificationStatus.seen: 'SEEN',
};
