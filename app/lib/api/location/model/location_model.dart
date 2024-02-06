import 'package:app/api/user/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/location_model.g.dart';

@JsonSerializable()
class LocationModel {
  final String id;
  final String uuid;
  final String name;
  int capacity;
  final List<String> solarTrackers;
  String? weatherStation;
  final String? cctv;
  final bool amIOwner;
  final List<BriefUserInfoModel> sharedWith;

  LocationModel(
    this.id,
    this.uuid,
    this.name,
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
