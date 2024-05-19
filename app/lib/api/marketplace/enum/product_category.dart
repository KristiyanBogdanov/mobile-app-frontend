import 'package:app/shared/constant/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

enum ProductCategory {
  @JsonValue('SOLAR_PANELS')
  solarPanels(AppStrings.solarPanelsProductCategory),
  @JsonValue('INVERTERS')
  inverters(AppStrings.invertersProductCategory),
  @JsonValue('BATTERIES')
  batteries(AppStrings.batteriesProductCategory),
  @JsonValue('CHARGE_CONTROLLERS')
  chargeControllers(AppStrings.chargeControllersProductCategory),
  @JsonValue('MOTORS')
  motors(AppStrings.motorsProductCategory),
  @JsonValue('CABLES_AND_CONNECTORS')
  cablesAndConnectors(AppStrings.cablesAndConnectorsProductCategory),
  @JsonValue('OTHER')
  other(AppStrings.otherProductCategory);

  final String name;
  const ProductCategory(this.name);

  static ProductCategory fromString(String value) {
    return ProductCategory.values.firstWhere((element) => element.name == value);
  }
}
