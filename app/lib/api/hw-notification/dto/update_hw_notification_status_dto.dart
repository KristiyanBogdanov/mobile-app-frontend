import 'package:app/api/hw-notification/enum/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/update_hw_notification_status_dto.g.dart';

@JsonSerializable()
class UpdateHwNotificationStatusDto {
  final NotificationStatus status;

  UpdateHwNotificationStatusDto(this.status);

  factory UpdateHwNotificationStatusDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateHwNotificationStatusDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateHwNotificationStatusDtoToJson(this);
}
