// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../auth_limits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLimitsModel _$AuthLimitsModelFromJson(Map<String, dynamic> json) => AuthLimitsModel(
      json['usernameMinLength'] as int,
      json['usernameMaxLength'] as int,
      json['passwordMinLength'] as int,
      json['passwordMaxLength'] as int,
      json['passwordMinNumbers'] as int,
      json['passwordMinLowercase'] as int,
      json['passwordMinUppercase'] as int,
    );

Map<String, dynamic> _$AuthLimitsModelToJson(AuthLimitsModel instance) => <String, dynamic>{
      'usernameMinLength': instance.usernameMinLength,
      'usernameMaxLength': instance.usernameMaxLength,
      'passwordMinLength': instance.passwordMinLength,
      'passwordMaxLength': instance.passwordMaxLength,
      'passwordMinNumbers': instance.passwordMinNumbers,
      'passwordMinLowercase': instance.passwordMinLowercase,
      'passwordMinUppercase': instance.passwordMinUppercase,
    };
