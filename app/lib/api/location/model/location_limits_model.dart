import 'package:json_annotation/json_annotation.dart';

part 'generated/location_limits_model.g.dart';

@JsonSerializable()
class LocationLimitsModel {
  final int nameMinLength;
  final int nameMaxLength;

  LocationLimitsModel(
    this.nameMinLength,
    this.nameMaxLength,
  );

  factory LocationLimitsModel.fromJson(Map<String, dynamic> json) => _$LocationLimitsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationLimitsModelToJson(this);
}