// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../location_insights_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationInsightsModel _$LocationInsightsModelFromJson(Map<String, dynamic> json) => LocationInsightsModel(
      (json['solarTrackers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SolarTrackerInsightsModel.fromJson(e as Map<String, dynamic>)),
      ),
      json['weatherStation'] == null
          ? null
          : WeatherStationInsightsModel.fromJson(json['weatherStation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationInsightsModelToJson(LocationInsightsModel instance) => <String, dynamic>{
      'solarTrackers': instance.solarTrackers,
      'weatherStation': instance.weatherStation,
    };
