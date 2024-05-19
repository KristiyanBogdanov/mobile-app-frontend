import 'package:app/api/location/model/solar_tracker_model.dart';
import 'package:app/api/user/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/location_model.g.dart';

@JsonSerializable()
class LocationModel {
  final String id;
  String name;
  List<SolarTrackerModel> solarTrackers;
  String? weatherStation;
  String? cctv;
  int capacity = 0;
  bool amIOwner;
  List<BriefUserInfoModel> sharedWith;

  LocationModel(
    this.id,
    this.name,
    this.solarTrackers,
    this.weatherStation,
    this.cctv,
    this.amIOwner,
    this.sharedWith,
  ) {
    capacity = solarTrackers.fold(0, (previousValue, st) => previousValue + st.capacity);
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  void copyWith(LocationModel location) {
    name = location.name;
    solarTrackers = location.solarTrackers;
    weatherStation = location.weatherStation;
    cctv = location.cctv;
    amIOwner = location.amIOwner;
    sharedWith = location.sharedWith;
  }
}
