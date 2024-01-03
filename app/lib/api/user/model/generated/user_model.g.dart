// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uuid'] as String,
      json['username'] as String,
      json['email'] as String,
      (json['locations'] as List<dynamic>).map((e) => LocationModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'email': instance.email,
      'locations': instance.locations,
    };
