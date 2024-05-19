// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../publications_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationsFiltersDto _$PublicationsFiltersDtoFromJson(Map<String, dynamic> json) => PublicationsFiltersDto(
      productCategories: (json['productCategories'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ProductCategoryEnumMap, e))
              .toList() ??
          ProductCategory.values,
      serviceCategories: (json['serviceCategories'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ServiceCategoryEnumMap, e))
              .toList() ??
          ServiceCategory.values,
    );

Map<String, dynamic> _$PublicationsFiltersDtoToJson(PublicationsFiltersDto instance) => <String, dynamic>{
      'productCategories': instance.productCategories.map((e) => _$ProductCategoryEnumMap[e]!).toList(),
      'serviceCategories': instance.serviceCategories.map((e) => _$ServiceCategoryEnumMap[e]!).toList(),
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

const _$ServiceCategoryEnumMap = {
  ServiceCategory.cleaning: 'CLEANING',
  ServiceCategory.legalConsulting: 'LEGAL_CONSULTING',
  ServiceCategory.designing: 'DESIGNING',
  ServiceCategory.performanceAnalysis: 'PERFORMANCE_ANALYSIS',
  ServiceCategory.installation: 'INSTALLATION',
  ServiceCategory.other: 'OTHER',
};
