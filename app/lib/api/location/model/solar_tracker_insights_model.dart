import 'package:app/api/location/model/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/solar_tracker_insights_model.g.dart';

@JsonSerializable()
class SolarTrackerSensorsStatusModel {
  final bool irradianceSensor;
  final bool accelerometer;
  final bool azimuthMotor;
  final bool elevationMotor;

  SolarTrackerSensorsStatusModel(
    this.irradianceSensor,
    this.accelerometer,
    this.azimuthMotor,
    this.elevationMotor,
  );

  factory SolarTrackerSensorsStatusModel.fromJson(Map<String, dynamic> json) =>
      _$SolarTrackerSensorsStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolarTrackerSensorsStatusModelToJson(this);

  int get count => 4;
}

@JsonSerializable()
class SolarTrackerInsightsModel {
  final String installationDate;
  final SolarTrackerSensorsStatusModel sensorsStatus;
  final bool isActive;
  final String lastUpdate;
  final CoordinatesModel coordinates;
  final double? currentAzimuth;
  final double? currentElevation;
  final double? azimuthDeviation;
  final double? elevationDeviation;
  final List<AverageSensorValueModel>? last24hAvgIrradiance;

  SolarTrackerInsightsModel(
    this.installationDate,
    this.sensorsStatus,
    this.isActive,
    this.lastUpdate,
    this.coordinates,
    this.currentAzimuth,
    this.currentElevation,
    this.azimuthDeviation,
    this.elevationDeviation,
    this.last24hAvgIrradiance,
  );

  factory SolarTrackerInsightsModel.fromJson(Map<String, dynamic> json) => _$SolarTrackerInsightsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolarTrackerInsightsModelToJson(this);
}
