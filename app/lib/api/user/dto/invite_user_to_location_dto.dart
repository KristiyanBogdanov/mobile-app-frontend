import 'package:json_annotation/json_annotation.dart';

part 'generated/invite_user_to_location_dto.g.dart';

@JsonSerializable()
class InviteUserToLocationDto {
  final String invitedUserEmail;
  final String locationId;

  InviteUserToLocationDto({
    required this.invitedUserEmail,
    required this.locationId,
  });

  factory InviteUserToLocationDto.fromJson(Map<String, dynamic> json) => _$InviteUserToLocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InviteUserToLocationDtoToJson(this);
}