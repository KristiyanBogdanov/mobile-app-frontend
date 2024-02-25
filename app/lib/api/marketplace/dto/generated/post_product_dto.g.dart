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
      json['condition'] as String,
      json['category'] as String,
    );

Map<String, dynamic> _$PostProductDtoToJson(PostProductDto instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'pricingOption': _$PricingOptionEnumMap[instance.pricingOption]!,
      'price': instance.price ?? {},
      'condition': instance.condition,
      'category': instance.category,
    };

const _$PricingOptionEnumMap = {
  PricingOption.fixed: 'FIXED',
  PricingOption.negotiable: 'NEGOTIABLE',
};
