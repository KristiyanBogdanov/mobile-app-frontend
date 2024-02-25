import 'package:json_annotation/json_annotation.dart';

enum PricingOption {
  @JsonValue('FIXED')
  fixed,
  @JsonValue('NEGOTIABLE')
  negotiable,
}