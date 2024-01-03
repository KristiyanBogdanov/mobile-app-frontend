// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../weather_station_insights_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherStationSensorsStatusModel _$WeatherStationSensorsStatusModelFromJson(
        Map<String, dynamic> json) =>
    WeatherStationSensorsStatusModel(
      json['anemometer'] as bool,
      json['temperatureSensor'] as bool,
    );

Map<String, dynamic> _$WeatherStationSensorsStatusModelToJson(
        WeatherStationSensorsStatusModel instance) =>
    <String, dynamic>{
      'anemometer': instance.anemometer,
      'temperatureSensor': instance.temperatureSensor,
    };

WeatherStationInsightsModel _$WeatherStationInsightsModelFromJson(
        Map<String, dynamic> json) =>
    WeatherStationInsightsModel(
      json['installationDate'] as String,
      WeatherStationSensorsStatusModel.fromJson(
          json['sensorsStatus'] as Map<String, dynamic>),
      json['isActive'] as bool,
      json['lastUpdate'] as String,
      CoordinatesModel.fromJson(json['coordinates'] as Map<String, dynamic>),
      (json['currentTemperature'] as num?)?.toDouble(),
      (json['currentWindSpeed'] as num?)?.toDouble(),
      json['currentWindDirection'] as String?,
      (json['last24hAvgTemperature'] as List<dynamic>?)
          ?.map((e) =>
              AverageSensorValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['last24hAvgWindSpeed'] as List<dynamic>?)
          ?.map((e) =>
              AverageSensorValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherStationInsightsModelToJson(
        WeatherStationInsightsModel instance) =>
    <String, dynamic>{
      'installationDate': instance.installationDate,
      'sensorsStatus': instance.sensorsStatus,
      'isActive': instance.isActive,
      'lastUpdate': instance.lastUpdate,
      'coordinates': instance.coordinates,
      'currentTemperature': instance.currentTemperature,
      'currentWindSpeed': instance.currentWindSpeed,
      'currentWindDirection': instance.currentWindDirection,
      'last24hAvgTemperature': instance.last24hAvgTemperature,
      'last24hAvgWindSpeed': instance.last24hAvgWindSpeed,
    };
