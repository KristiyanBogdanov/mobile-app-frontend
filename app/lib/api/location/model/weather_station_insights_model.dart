import 'package:app/api/location/model/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/weather_station_insights_model.g.dart';

@JsonSerializable()
class WeatherStationSensorsStatusModel {
  final bool anemometer;
  final bool temperatureSensor;

  WeatherStationSensorsStatusModel(
    this.anemometer,
    this.temperatureSensor,
  );

  factory WeatherStationSensorsStatusModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherStationSensorsStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStationSensorsStatusModelToJson(this);

  int get count => 2;
}

@JsonSerializable()
class WeatherStationInsightsModel {
  final String installationDate;
  final WeatherStationSensorsStatusModel sensorsStatus;
  final bool isActive;
  final String lastUpdate;
  final CoordinatesModel coordinates;
  final double? currentTemperature;
  final double? currentWindSpeed;
  final String? currentWindDirection;
  final List<AverageSensorValueModel>? last24hAvgTemperature;
  final List<AverageSensorValueModel>? last24hAvgWindSpeed;

  WeatherStationInsightsModel(
    this.installationDate,
    this.sensorsStatus,
    this.isActive,
    this.lastUpdate,
    this.coordinates,
    this.currentTemperature,
    this.currentWindSpeed,
    this.currentWindDirection,
    this.last24hAvgTemperature,
    this.last24hAvgWindSpeed,
  );

  factory WeatherStationInsightsModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherStationInsightsModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStationInsightsModelToJson(this);
}
