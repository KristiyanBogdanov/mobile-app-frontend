// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_publications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPublicationsModel _$GetPublicationsModelFromJson(Map<String, dynamic> json) => GetPublicationsModel(
      json['totalItems'] as int,
      json['page'] as int,
      json['limit'] as int,
      (json['items'] as List<dynamic>).map((e) => ItemModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$GetPublicationsModelToJson(GetPublicationsModel instance) => <String, dynamic>{
      'totalItems': instance.totalItems,
      'page': instance.page,
      'limit': instance.limit,
      'items': instance.items,
    };
