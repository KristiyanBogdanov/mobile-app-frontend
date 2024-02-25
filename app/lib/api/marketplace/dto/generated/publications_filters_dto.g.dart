// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../publications_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationsFiltersDto _$PublicationsFiltersDtoFromJson(Map<String, dynamic> json) => PublicationsFiltersDto(
      productCategories: (json['productCategories'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      serviceCategories: (json['serviceCategories'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    );

Map<String, dynamic> _$PublicationsFiltersDtoToJson(PublicationsFiltersDto instance) => <String, dynamic>{
      'productCategories': instance.productCategories,
      'serviceCategories': instance.serviceCategories,
    };
