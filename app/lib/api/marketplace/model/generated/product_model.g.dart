// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      $enumDecode(_$PricingOptionEnumMap, json['pricingOption']),
      (json['price'] as num?)?.toDouble(),
      json['createdAt'] as String,
      json['amIPublisher'] as bool,
      BriefUserInfoModel.fromJson(json['publisher'] as Map<String, dynamic>),
      $enumDecode(_$ProductConditionEnumMap, json['condition']),
      $enumDecode(_$ProductCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'pricingOption': _$PricingOptionEnumMap[instance.pricingOption]!,
      'price': instance.price,
      'createdAt': instance.createdAt,
      'amIPublisher': instance.amIPublisher,
      'publisher': instance.publisher,
      'condition': _$ProductConditionEnumMap[instance.condition]!,
      'category': _$ProductCategoryEnumMap[instance.category]!,
    };

const _$PricingOptionEnumMap = {
  PricingOption.fixed: 'FIXED',
  PricingOption.negotiable: 'NEGOTIABLE',
};

const _$ProductConditionEnumMap = {
  ProductCondition.newT: 'NEW',
  ProductCondition.used: 'USED',
};

const _$ProductCategoryEnumMap = {
  ProductCategory.solarPanels: 'SOLAR_PANELS',
  ProductCategory.inverters: 'INVERTERS',
  ProductCategory.batteries: 'BATTERIES',
  ProductCategory.chargeControllers: 'CHARGE_CONTROLLERS',
  ProductCategory.motors: 'MOTORS',
  ProductCategory.cablesAndConnectors: 'CABLES_AND_CONNECTORS',
  ProductCategory.other: 'OTHER',
};
