import 'package:app/api/hw-notification/index.dart';
import 'package:app/api/invitation/model/invitation_model.dart';
import 'package:app/api/location/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  final String email;
  final List<LocationModel> locations;
  List<HwNotificationModel> hwNotifications;
  List<InvitationModel> invitations;

  UserModel(
    this.id,
    this.username,
    this.email,
    this.locations,
    this.hwNotifications,
    this.invitations,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
