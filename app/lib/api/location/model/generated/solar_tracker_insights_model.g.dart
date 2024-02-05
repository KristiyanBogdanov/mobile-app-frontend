// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../solar_tracker_insights_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolarTrackerSensorsStatusModel _$SolarTrackerSensorsStatusModelFromJson(Map<String, dynamic> json) =>
    SolarTrackerSensorsStatusModel(
      json['irradianceSensor'] as bool,
      json['accelerometer'] as bool,
      json['azimuthMotor'] as bool,
      json['elevationMotor'] as bool,
    );

Map<String, dynamic> _$SolarTrackerSensorsStatusModelToJson(SolarTrackerSensorsStatusModel instance) =>
    <String, dynamic>{
      'irradianceSensor': instance.irradianceSensor,
      'accelerometer': instance.accelerometer,
      'azimuthMotor': instance.azimuthMotor,
      'elevationMotor': instance.elevationMotor,
    };

SolarTrackerInsightsModel _$SolarTrackerInsightsModelFromJson(Map<String, dynamic> json) => SolarTrackerInsightsModel(
      json['installationDate'] as String,
      SolarTrackerSensorsStatusModel.fromJson(json['sensorsStatus'] as Map<String, dynamic>),
      json['isActive'] as bool,
      json['capacity'] as int,
      json['lastUpdate'] as String,
      CoordinatesModel.fromJson(json['coordinates'] as Map<String, dynamic>),
      (json['currentAzimuth'] as num?)?.toDouble(),
      (json['currentElevation'] as num?)?.toDouble(),
      (json['azimuthDeviation'] as num?)?.toDouble(),
      (json['elevationDeviation'] as num?)?.toDouble(),
      (json['last24hAvgIrradiance'] as List<dynamic>?)
          ?.map((e) => AverageSensorValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SolarTrackerInsightsModelToJson(SolarTrackerInsightsModel instance) => <String, dynamic>{
      'installationDate': instance.installationDate,
      'sensorsStatus': instance.sensorsStatus,
      'isActive': instance.isActive,
      'capacity': instance.capacity,
      'lastUpdate': instance.lastUpdate,
      'coordinates': instance.coordinates,
      'currentAzimuth': instance.currentAzimuth,
      'currentElevation': instance.currentElevation,
      'azimuthDeviation': instance.azimuthDeviation,
      'elevationDeviation': instance.elevationDeviation,
      'last24hAvgIrradiance': instance.last24hAvgIrradiance,
    };
