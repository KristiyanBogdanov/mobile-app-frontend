// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../invitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationModel _$InvitationModelFromJson(Map<String, dynamic> json) => InvitationModel(
      json['id'] as String,
      json['locationId'] as String,
      json['locationName'] as String,
      json['ownerUsername'] as String,
      json['timestamp'] as String,
    );

Map<String, dynamic> _$InvitationModelToJson(InvitationModel instance) => <String, dynamic>{
      'id': instance.id,
      'locationId': instance.locationId,
      'locationName': instance.locationName,
      'ownerUsername': instance.ownerUsername,
      'timestamp': instance.timestamp,
    };
