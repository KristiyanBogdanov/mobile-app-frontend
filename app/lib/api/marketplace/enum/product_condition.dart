import 'package:app/shared/constant/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

enum ProductCondition {
  @JsonValue('NEW')
  newT(AppStrings.newProductCondition),
  @JsonValue('USED')
  used(AppStrings.usedProductCondition);

  final String name;
  const ProductCondition(this.name);

  static ProductCondition fromString(String value) {
    return ProductCondition.values.firstWhere((element) => element.name == value);
  }
}
