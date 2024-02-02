// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../new_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewLocationDto _$NewLocationDtoFromJson(Map<String, dynamic> json) => NewLocationDto(
      json['name'] as String,
      json['capacity'] as int,
      (json['solarTrackers'] as List<dynamic>).map((e) => e as String).toList(),
      json['weatherStation'] as String?,
      json['cctv'] as String?,
    );

Map<String, dynamic> _$NewLocationDtoToJson(NewLocationDto instance) => <String, dynamic>{
      'name': instance.name,
      'capacity': instance.capacity,
      'solarTrackers': instance.solarTrackers,
      'weatherStation': instance.weatherStation,
      'cctv': instance.cctv,
    };
