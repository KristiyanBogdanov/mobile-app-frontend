import 'package:json_annotation/json_annotation.dart';

const deviceStateReportName = 'DEVICE_STATE_REPORT';
const inactiveDeviceName = 'INACTIVE_DEVICE';
const locationUpdateName = 'LOCATION_UPDATE';
const invitationName = 'INVITATION';
const invitationUpdateName = 'INVITATION_UPDATE';

enum NotificationType {
  @JsonValue(deviceStateReportName)
  deviceStateReport(deviceStateReportName),
  @JsonValue(inactiveDeviceName)
  inactiveDevice(inactiveDeviceName),
  @JsonValue(locationUpdateName)
  locationUpdate(locationUpdateName),
  @JsonValue(invitationName)
  invitation(invitationName),
  @JsonValue(invitationUpdateName)
  invitationUpdate(invitationUpdateName);

  final String name;
  const NotificationType(this.name);
}
