// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../post_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostProductDto _$PostProductDtoFromJson(Map<String, dynamic> json) => PostProductDto(
      json['title'] as String,
      json['description'] as String,
      $enumDecode(_$PricingOptionEnumMap, json['pricingOption']),
      (json['price'] as num?)?.toDouble(),
      $enumDecode(_$ProductConditionEnumMap, json['condition']),
      $enumDecode(_$ProductCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$PostProductDtoToJson(PostProductDto instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'pricingOption': _$PricingOptionEnumMap[instance.pricingOption]!,
      'price': instance.price ?? {},
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
