// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../invite_user_to_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteUserToLocationDto _$InviteUserToLocationDtoFromJson(Map<String, dynamic> json) => InviteUserToLocationDto(
      invitedUserEmail: json['invitedUserEmail'] as String,
      locationId: json['locationId'] as String,
    );

Map<String, dynamic> _$InviteUserToLocationDtoToJson(InviteUserToLocationDto instance) => <String, dynamic>{
      'invitedUserEmail': instance.invitedUserEmail,
      'locationId': instance.locationId,
    };
