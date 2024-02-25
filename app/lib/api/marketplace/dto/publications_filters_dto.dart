import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/publications_filters_dto.g.dart';

@JsonSerializable()
class PublicationsFiltersDto {
  List<String> productCategories;
  List<String> serviceCategories;

  PublicationsFiltersDto({
    this.productCategories = const [],
    this.serviceCategories = const [],
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PublicationsFiltersDto &&
        listEquals(other.productCategories, productCategories) &&
        listEquals(other.serviceCategories, serviceCategories);
  }

  @override
  int get hashCode => productCategories.hashCode ^ serviceCategories.hashCode;

  factory PublicationsFiltersDto.fromJson(Map<String, dynamic> json) => _$PublicationsFiltersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationsFiltersDtoToJson(this);
}
