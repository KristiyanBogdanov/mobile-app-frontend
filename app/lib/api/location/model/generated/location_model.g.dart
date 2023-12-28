// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      json['uuid'] as String,
      json['name'] as String,
      json['location'] as String,
      json['capacity'] as num,
      (json['solarTrackers'] as List<dynamic>).map((e) => e as String).toList(),
      json['weatherStation'] as String?,
      json['cctv'] as String?,
      json['amIOwner'] as bool,
      (json['sharedWith'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'location': instance.location,
      'capacity': instance.capacity,
      'solarTrackers': instance.solarTrackers,
      'weatherStation': instance.weatherStation,
      'cctv': instance.cctv,
      'amIOwner': instance.amIOwner,
      'sharedWith': instance.sharedWith,
    };
