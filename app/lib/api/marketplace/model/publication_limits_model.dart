import 'package:json_annotation/json_annotation.dart';

part 'generated/publication_limits_model.g.dart';

@JsonSerializable()
class PublicationLimitsModel {
  final int tileMinLength;
  final int titleMaxLength;
  final List<String> productConditionOptions;
  final List<String> productCategories;
  final List<String> serviceCategories;

  PublicationLimitsModel(
    this.tileMinLength,
    this.titleMaxLength,
    this.productConditionOptions,
    this.productCategories,
    this.serviceCategories,
  );

  factory PublicationLimitsModel.fromJson(Map<String, dynamic> json) => _$PublicationLimitsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationLimitsModelToJson(this);
}
