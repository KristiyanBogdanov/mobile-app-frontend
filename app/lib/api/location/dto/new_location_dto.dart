import 'package:json_annotation/json_annotation.dart';

part 'generated/new_location_dto.g.dart';

@JsonSerializable()
class NewLocationDto {
  final String name;
  final String location;
  final int capacity;
  final List<String> solarTrackers;
  final String? weatherStation;
  final String? cctv;

  NewLocationDto(
    this.name,
    this.location,
    this.capacity,
    this.solarTrackers,
    this.weatherStation,
    this.cctv,
  );

  factory NewLocationDto.fromJson(Map<String, dynamic> json) => _$NewLocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewLocationDtoToJson(this);
}
