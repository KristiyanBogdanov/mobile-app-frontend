import 'package:json_annotation/json_annotation.dart';

part 'generated/validate_serial_number_dto.g.dart';

@JsonSerializable()
class ValidateSerialNumberDto {
  final bool isValid;
  final bool? isUsed;
  final bool? isAdded;

  ValidateSerialNumberDto(
    this.isValid,
    this.isUsed,
    this.isAdded,
  );

  factory ValidateSerialNumberDto.fromJson(Map<String, dynamic> json) => _$ValidateSerialNumberDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateSerialNumberDtoToJson(this);
}
