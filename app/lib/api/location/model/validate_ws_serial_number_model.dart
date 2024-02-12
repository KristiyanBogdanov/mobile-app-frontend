import 'package:json_annotation/json_annotation.dart';

part 'generated/validate_ws_serial_number_model.g.dart';

@JsonSerializable()
class ValidateWSSerialNumberModel {
  final bool isValid;
  final bool? isUsed;
  final bool? isAdded;

  ValidateWSSerialNumberModel(
    this.isValid,
    this.isUsed,
    this.isAdded,
  );

  factory ValidateWSSerialNumberModel.fromJson(Map<String, dynamic> json) => _$ValidateWSSerialNumberModelFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateWSSerialNumberModelToJson(this);
}
