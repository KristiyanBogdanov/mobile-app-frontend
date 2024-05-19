import 'package:app/shared/constant/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

enum PublicationType {
  @JsonValue('PRODUCT')
  product(AppStrings.productPublicationType),
  @JsonValue('SERVICE')
  service(AppStrings.servicePublicationType);

  final String name;
  const PublicationType(this.name);

  static PublicationType fromString(String value) {
    return PublicationType.values.firstWhere((element) => element.name == value);
  }
}
