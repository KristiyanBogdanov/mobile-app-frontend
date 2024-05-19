import 'package:json_annotation/json_annotation.dart';

part 'generated/auth_limits_model.g.dart';

@JsonSerializable()
class AuthLimitsModel {
  final int usernameMinLength;
  final int usernameMaxLength;
  final int passwordMinLength;
  final int passwordMaxLength;
  final int passwordMinNumbers;
  final int passwordMinLowercase;
  final int passwordMinUppercase;

  AuthLimitsModel(
    this.usernameMinLength,
    this.usernameMaxLength,
    this.passwordMinLength,
    this.passwordMaxLength,
    this.passwordMinNumbers,
    this.passwordMinLowercase,
    this.passwordMinUppercase,
  );

  factory AuthLimitsModel.fromJson(Map<String, dynamic> json) => _$AuthLimitsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLimitsModelToJson(this);
}
