import 'package:app/api/location/model/solar_tracker_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/validate_st_serial_number_model.g.dart';

@JsonSerializable()
class ValidateSTSerialNumberModel {
  final bool isValid;
  final bool? isUsed;
  final bool? isAdded;
  final SolarTrackerModel? solarTracker;

  ValidateSTSerialNumberModel(
    this.isValid,
    this.isUsed,
    this.isAdded,
    this.solarTracker,
  );

  factory ValidateSTSerialNumberModel.fromJson(Map<String, dynamic> json) => _$ValidateSTSerialNumberModelFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateSTSerialNumberModelToJson(this);
}