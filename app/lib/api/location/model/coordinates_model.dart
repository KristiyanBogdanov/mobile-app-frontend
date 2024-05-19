import 'package:json_annotation/json_annotation.dart';

part 'generated/coordinates_model.g.dart';

@JsonSerializable()
class CoordinatesModel {
  final double longitude;
  final double latitude;

  CoordinatesModel(
    this.longitude,
    this.latitude,
  );

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) => _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}
