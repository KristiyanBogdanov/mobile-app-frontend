// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../signup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpDto _$SignUpDtoFromJson(Map<String, dynamic> json) => SignUpDto(
      json['username'] as String,
      json['email'] as String,
      json['password'] as String,
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$SignUpDtoToJson(SignUpDto instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'fcmToken': instance.fcmToken,
    };
