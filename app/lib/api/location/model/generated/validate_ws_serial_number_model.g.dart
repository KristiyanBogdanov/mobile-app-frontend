// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../validate_ws_serial_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateWSSerialNumberModel _$ValidateWSSerialNumberModelFromJson(Map<String, dynamic> json) =>
    ValidateWSSerialNumberModel(
      json['isValid'] as bool,
      json['isUsed'] as bool?,
      json['isAdded'] as bool?,
    );

Map<String, dynamic> _$ValidateWSSerialNumberModelToJson(ValidateWSSerialNumberModel instance) => <String, dynamic>{
      'isValid': instance.isValid,
      'isUsed': instance.isUsed,
      'isAdded': instance.isAdded,
    };
