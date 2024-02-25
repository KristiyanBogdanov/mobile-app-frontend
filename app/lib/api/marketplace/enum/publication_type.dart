import 'package:json_annotation/json_annotation.dart';

enum PublicationType {
  @JsonValue('PRODUCT')
  product,
  @JsonValue('SERVICE')
  service,
}