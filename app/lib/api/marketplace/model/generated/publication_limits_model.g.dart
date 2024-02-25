// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../publication_limits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationLimitsModel _$PublicationLimitsModelFromJson(Map<String, dynamic> json) => PublicationLimitsModel(
      json['tileMinLength'] as int,
      json['titleMaxLength'] as int,
      (json['productConditionOptions'] as List<dynamic>).map((e) => e as String).toList(),
      (json['productCategories'] as List<dynamic>).map((e) => e as String).toList(),
      (json['serviceCategories'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PublicationLimitsModelToJson(PublicationLimitsModel instance) => <String, dynamic>{
      'tileMinLength': instance.tileMinLength,
      'titleMaxLength': instance.titleMaxLength,
      'productConditionOptions': instance.productConditionOptions,
      'productCategories': instance.productCategories,
      'serviceCategories': instance.serviceCategories,
    };
