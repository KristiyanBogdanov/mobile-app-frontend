import 'package:json_annotation/json_annotation.dart';

part 'generated/respond_to_invitation_dto.g.dart';

@JsonSerializable()
class RespondToInvitationDto {
  final String locationId;
  final bool accepted;

  RespondToInvitationDto({
    required this.locationId,
    required this.accepted,
  });

  factory RespondToInvitationDto.fromJson(Map<String, dynamic> json) => _$RespondToInvitationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RespondToInvitationDtoToJson(this);
}
