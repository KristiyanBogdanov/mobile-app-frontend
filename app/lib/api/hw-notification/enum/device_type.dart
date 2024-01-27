import 'package:json_annotation/json_annotation.dart';

enum DeviceType {
  @JsonValue('SOLAR_TRACKER')
  solarTracker,
  @JsonValue('WEATHER_STATION')
  weatherStation
}
