// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../validate_st_serial_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateSTSerialNumberModel _$ValidateSTSerialNumberModelFromJson(Map<String, dynamic> json) =>
    ValidateSTSerialNumberModel(
      json['isValid'] as bool,
      json['isUsed'] as bool?,
      json['isAdded'] as bool?,
      json['solarTracker'] == null ? null : SolarTrackerModel.fromJson(json['solarTracker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidateSTSerialNumberModelToJson(ValidateSTSerialNumberModel instance) => <String, dynamic>{
      'isValid': instance.isValid,
      'isUsed': instance.isUsed,
      'isAdded': instance.isAdded,
      'solarTracker': instance.solarTracker,
    };
