import 'package:json_annotation/json_annotation.dart';

enum HwNotificationImportance {
  @JsonValue('INFORMATION')
  information,
  @JsonValue('WARNING')
  warning,
  @JsonValue('CRITICAL')
  critical
}
