// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      $enumDecode(_$PublicationTypeEnumMap, json['type']),
      json['type'] == 'PRODUCT'
          ? ProductModel.fromJson(json['data'] as Map<String, dynamic>)
          : ServiceModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'type': _$PublicationTypeEnumMap[instance.type]!,
      'data': instance.data,
    };

const _$PublicationTypeEnumMap = {
  PublicationType.product: 'PRODUCT',
  PublicationType.service: 'SERVICE',
};
