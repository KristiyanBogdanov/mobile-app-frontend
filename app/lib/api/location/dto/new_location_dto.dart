import 'package:json_annotation/json_annotation.dart';

part 'generated/new_location_dto.g.dart';

@JsonSerializable()
class NewLocationDto {
  final String name;
  final List<String> solarTrackerSerialNumbers;
  final String? weatherStation;
  final String? cctv;

  NewLocationDto(
    this.name,
    this.solarTrackerSerialNumbers,
    this.weatherStation,
    this.cctv,
  );

  factory NewLocationDto.fromJson(Map<String, dynamic> json) => _$NewLocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewLocationDtoToJson(this);
}
