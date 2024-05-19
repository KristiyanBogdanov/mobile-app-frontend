// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../location_limits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationLimitsModel _$LocationLimitsModelFromJson(Map<String, dynamic> json) => LocationLimitsModel(
      json['nameMinLength'] as int,
      json['nameMaxLength'] as int,
    );

Map<String, dynamic> _$LocationLimitsModelToJson(LocationLimitsModel instance) => <String, dynamic>{
      'nameMinLength': instance.nameMinLength,
      'nameMaxLength': instance.nameMaxLength,
    };
