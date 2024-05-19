import 'package:json_annotation/json_annotation.dart';

part 'generated/signup_dto.g.dart';

@JsonSerializable()
class SignUpDto {
  final String username;
  final String email;
  final String password;
  final String fcmToken;

  SignUpDto(
    this.username,
    this.email,
    this.password,
    this.fcmToken,
  );

  factory SignUpDto.fromJson(Map<String, dynamic> json) => _$SignUpDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpDtoToJson(this);
}
