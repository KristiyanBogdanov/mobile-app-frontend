import 'package:app/api/location/model/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/location_insights_model.g.dart';

@JsonSerializable()
class LocationInsightsModel {
  final CoordinatesModel? coordinates; // TODO: Remove nullable!!!!
  final Map<String, SolarTrackerInsightsModel> solarTrackers;
  final WeatherStationInsightsModel? weatherStation;

  LocationInsightsModel(
    this.coordinates,
    this.solarTrackers,
    this.weatherStation,
  );

  factory LocationInsightsModel.fromJson(Map<String, dynamic> json) => _$LocationInsightsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationInsightsModelToJson(this);
}
