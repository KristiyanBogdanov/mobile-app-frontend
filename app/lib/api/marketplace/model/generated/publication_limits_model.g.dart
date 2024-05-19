// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../publication_limits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationLimitsModel _$PublicationLimitsModelFromJson(
        Map<String, dynamic> json) =>
    PublicationLimitsModel(
      json['tileMinLength'] as int,
      json['titleMaxLength'] as int,
    );

Map<String, dynamic> _$PublicationLimitsModelToJson(
        PublicationLimitsModel instance) =>
    <String, dynamic>{
      'tileMinLength': instance.tileMinLength,
      'titleMaxLength': instance.titleMaxLength,
    };
