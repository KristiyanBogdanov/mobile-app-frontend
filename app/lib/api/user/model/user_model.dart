import 'package:app/api/hw-notification/index.dart';
import 'package:app/api/location/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  final String email;
  final List<LocationModel> locations;
  final List<HwNotificationModel> hwNotifications;

  UserModel(
    this.id,
    this.username,
    this.email,
    this.locations,
    this.hwNotifications,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
