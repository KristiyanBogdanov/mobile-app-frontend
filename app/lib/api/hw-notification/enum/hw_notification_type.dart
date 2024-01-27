import 'package:json_annotation/json_annotation.dart';

enum HwNotificationType {
  @JsonValue('DEVICE_STATE')
  deviceState,
  @JsonValue('INACTIVE_DEVICE')
  inactiveDevice,
}
