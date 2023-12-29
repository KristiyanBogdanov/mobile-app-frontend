// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../signin_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInDto _$SignInDtoFromJson(Map<String, dynamic> json) => SignInDto(
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$SignInDtoToJson(SignInDto instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
