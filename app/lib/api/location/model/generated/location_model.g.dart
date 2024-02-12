// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) => LocationModel(
      json['id'] as String,
      json['name'] as String,
      (json['solarTrackers'] as List<dynamic>)
          .map((e) => SolarTrackerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['weatherStation'] as String?,
      json['cctv'] as String?,
      json['amIOwner'] as bool,
      (json['sharedWith'] as List<dynamic>).map((e) => BriefUserInfoModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'solarTrackers': instance.solarTrackers,
      'weatherStation': instance.weatherStation,
      'cctv': instance.cctv,
      'amIOwner': instance.amIOwner,
      'sharedWith': instance.sharedWith,
    };
