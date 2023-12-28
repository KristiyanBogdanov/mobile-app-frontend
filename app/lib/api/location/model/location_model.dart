import 'package:json_annotation/json_annotation.dart';

part 'generated/location_model.g.dart';

@JsonSerializable()
class LocationModel {
  final String uuid;
  final String name;
  final String location;
  final num capacity;
  final List<String> solarTrackers;
  final String? weatherStation;
  final String? cctv;
  final bool amIOwner;
  final List<String> sharedWith;

  LocationModel(
    this.uuid,
    this.name,
    this.location,
    this.capacity,
    this.solarTrackers,
    this.weatherStation,
    this.cctv,
    this.amIOwner,
    this.sharedWith,
  );

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
