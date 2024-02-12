import 'package:json_annotation/json_annotation.dart';

part 'generated/solar_tracker_model.g.dart';

@JsonSerializable()
class SolarTrackerModel {
  final String serialNumber;
  final int capacity;

  SolarTrackerModel(
    this.serialNumber,
    this.capacity,
  );

  factory SolarTrackerModel.fromJson(Map<String, dynamic> json) => _$SolarTrackerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolarTrackerModelToJson(this);
}
