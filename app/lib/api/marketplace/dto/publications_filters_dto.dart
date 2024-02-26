import 'package:app/api/marketplace/enum/index.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/publications_filters_dto.g.dart';

@JsonSerializable()
class PublicationsFiltersDto {
  List<ProductCategory> productCategories;
  List<ServiceCategory> serviceCategories;

  PublicationsFiltersDto({
    this.productCategories = ProductCategory.values,
    this.serviceCategories = ServiceCategory.values,
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
