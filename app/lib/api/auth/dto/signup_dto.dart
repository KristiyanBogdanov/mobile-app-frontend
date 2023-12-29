import 'package:json_annotation/json_annotation.dart';

part 'generated/signup_dto.g.dart';

@JsonSerializable()
class SignUpDto {
  final String username;
  final String email;
  final String password;

  SignUpDto(
    this.username,
    this.email,
    this.password,
  );

  factory SignUpDto.fromJson(Map<String, dynamic> json) => _$SignUpDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpDtoToJson(this);
}
