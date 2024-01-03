import 'package:json_annotation/json_annotation.dart';

part 'generated/average_sensor_value_model.g.dart';

@JsonSerializable()
class AverageSensorValueModel {
  final int id;
  final double? average;

  AverageSensorValueModel(
    this.id,
    this.average,
  );

  factory AverageSensorValueModel.fromJson(Map<String, dynamic> json) => _$AverageSensorValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$AverageSensorValueModelToJson(this);
}
