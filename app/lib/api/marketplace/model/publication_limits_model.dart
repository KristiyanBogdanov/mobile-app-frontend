import 'package:json_annotation/json_annotation.dart';

part 'generated/publication_limits_model.g.dart';

@JsonSerializable()
class PublicationLimitsModel {
  final int tileMinLength;
  final int titleMaxLength;

  PublicationLimitsModel(
    this.tileMinLength,
    this.titleMaxLength,
  );

  factory PublicationLimitsModel.fromJson(Map<String, dynamic> json) => _$PublicationLimitsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicationLimitsModelToJson(this);
}
