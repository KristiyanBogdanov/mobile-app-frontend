import 'package:app/shared/constant/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

enum PricingOption {
  @JsonValue('FIXED')
  fixed(AppStrings.fixedPricingOption),
  @JsonValue('NEGOTIABLE')
  negotiable(AppStrings.negotiablePricingOption);

  final String name;
  const PricingOption(this.name);

  static PricingOption fromString(String value) {
    return PricingOption.values.firstWhere((element) => element.name == value);
  }
}
