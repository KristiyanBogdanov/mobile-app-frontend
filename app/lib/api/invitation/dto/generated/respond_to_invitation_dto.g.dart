// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../respond_to_invitation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespondToInvitationDto _$RespondToInvitationDtoFromJson(Map<String, dynamic> json) => RespondToInvitationDto(
      locationId: json['locationId'] as String,
      accepted: json['accepted'] as bool,
    );

Map<String, dynamic> _$RespondToInvitationDtoToJson(RespondToInvitationDto instance) => <String, dynamic>{
      'locationId': instance.locationId,
      'accepted': instance.accepted,
    };
