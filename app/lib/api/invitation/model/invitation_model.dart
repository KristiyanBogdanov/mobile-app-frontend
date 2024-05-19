import 'package:json_annotation/json_annotation.dart';

part 'generated/invitation_model.g.dart';

@JsonSerializable()
class InvitationModel {
  final String id;
  final String locationId;
  final String locationName;
  final String ownerUsername;
  final String timestamp;

  InvitationModel(
    this.id,
    this.locationId,
    this.locationName,
    this.ownerUsername,
    this.timestamp,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvitationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory InvitationModel.fromJson(Map<String, dynamic> json) => _$InvitationModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationModelToJson(this);
}
