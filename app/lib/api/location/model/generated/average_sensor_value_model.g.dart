// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../average_sensor_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AverageSensorValueModel _$AverageSensorValueModelFromJson(
        Map<String, dynamic> json) =>
    AverageSensorValueModel(
      json['id'] as int,
      (json['average'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AverageSensorValueModelToJson(
        AverageSensorValueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'average': instance.average,
    };
