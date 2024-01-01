// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../validate_serial_number_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateSerialNumberDto _$ValidateSerialNumberDtoFromJson(
        Map<String, dynamic> json) =>
    ValidateSerialNumberDto(
      json['isValid'] as bool,
      json['isUsed'] as bool?,
      json['isAdded'] as bool?,
    );

Map<String, dynamic> _$ValidateSerialNumberDtoToJson(
        ValidateSerialNumberDto instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'isUsed': instance.isUsed,
      'isAdded': instance.isAdded,
    };
