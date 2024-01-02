import 'package:json_annotation/json_annotation.dart';

part 'generated/brief_user_info_model.g.dart';

@JsonSerializable()
class BriefUserInfoModel {
  final String uuid;
  final String username;

  BriefUserInfoModel(
    this.uuid,
    this.username
  );

  factory BriefUserInfoModel.fromJson(Map<String, dynamic> json) => _$BriefUserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$BriefUserInfoModelToJson(this);
}
