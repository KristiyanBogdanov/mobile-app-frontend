import 'package:app/api/location/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String uuid;
  final String username;
  final String email;
  final List<LocationModel> locations;

  UserModel(
    this.uuid,
    this.username,
    this.email,
    this.locations,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
