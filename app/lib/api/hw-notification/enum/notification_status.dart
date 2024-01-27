import 'package:json_annotation/json_annotation.dart';

enum NotificationStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('SEEN')
  seen,
}
