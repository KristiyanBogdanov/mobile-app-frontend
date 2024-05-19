// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      $enumDecode(_$PricingOptionEnumMap, json['pricingOption']),
      (json['price'] as num?)?.toDouble(),
      json['createdAt'] as String,
      json['amIPublisher'] as bool,
      BriefUserInfoModel.fromJson(json['publisher'] as Map<String, dynamic>),
      $enumDecode(_$ServiceCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'pricingOption': _$PricingOptionEnumMap[instance.pricingOption]!,
      'price': instance.price,
      'createdAt': instance.createdAt,
      'amIPublisher': instance.amIPublisher,
      'publisher': instance.publisher,
      'category': _$ServiceCategoryEnumMap[instance.category]!,
    };

const _$PricingOptionEnumMap = {
  PricingOption.fixed: 'FIXED',
  PricingOption.negotiable: 'NEGOTIABLE',
};

const _$ServiceCategoryEnumMap = {
  ServiceCategory.cleaning: 'CLEANING',
  ServiceCategory.legalConsulting: 'LEGAL_CONSULTING',
  ServiceCategory.designing: 'DESIGNING',
  ServiceCategory.performanceAnalysis: 'PERFORMANCE_ANALYSIS',
  ServiceCategory.installation: 'INSTALLATION',
  ServiceCategory.other: 'OTHER',
};
