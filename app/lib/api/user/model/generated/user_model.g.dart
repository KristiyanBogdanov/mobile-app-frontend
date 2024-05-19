// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as String,
      json['username'] as String,
      json['email'] as String,
      (json['locations'] as List<dynamic>).map((e) => LocationModel.fromJson(e as Map<String, dynamic>)).toList(),
      (json['hwNotifications'] as List<dynamic>)
          .map((e) => HwNotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['invitations'] as List<dynamic>).map((e) => InvitationModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'locations': instance.locations,
      'hwNotifications': instance.hwNotifications,
      'invitations': instance.invitations,
    };
