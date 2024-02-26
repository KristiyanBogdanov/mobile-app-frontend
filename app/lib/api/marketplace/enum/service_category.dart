import 'package:app/shared/constant/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

enum ServiceCategory {
  @JsonValue('CLEANING')
  cleaning(AppStrings.cleaningServiceCategory),
  @JsonValue('LEGAL_CONSULTING')
  legalConsulting(AppStrings.legalConsultingServiceCategory),
  @JsonValue('DESIGNING')
  designing(AppStrings.designingServiceCategory),
  @JsonValue('PERFORMANCE_ANALYSIS')
  performanceAnalysis(AppStrings.performanceAnalysisServiceCategory),
  @JsonValue('INSTALLATION')
  installation(AppStrings.installationServiceCategory),
  @JsonValue('OTHER')
  other(AppStrings.otherServiceCategory);

  final String name;
  const ServiceCategory(this.name);

  static ServiceCategory fromString(String value) {
    return ServiceCategory.values.firstWhere((element) => element.name == value);
  }
}
