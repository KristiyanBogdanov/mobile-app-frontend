// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../post_service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostServiceDto _$PostServiceDtoFromJson(Map<String, dynamic> json) => PostServiceDto(
      json['title'] as String,
      json['description'] as String,
      $enumDecode(_$PricingOptionEnumMap, json['pricingOption']),
      (json['price'] as num?)?.toDouble(),
      json['category'] as String,
    );

Map<String, dynamic> _$PostServiceDtoToJson(PostServiceDto instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'pricingOption': _$PricingOptionEnumMap[instance.pricingOption]!,
      'price': instance.price,
      'category': instance.category,
    };

const _$PricingOptionEnumMap = {
  PricingOption.fixed: 'FIXED',
  PricingOption.negotiable: 'NEGOTIABLE',
};
