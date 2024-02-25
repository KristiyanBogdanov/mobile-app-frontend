import 'package:app/api/marketplace/enum/pricing_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/post_service_dto.g.dart';

@JsonSerializable()
class PostServiceDto {
  final String title;
  final String description;
  final PricingOption pricingOption;
  final double? price;
  final String category;

  PostServiceDto(
    this.title,
    this.description,
    this.pricingOption,
    this.price,
    this.category,
  );

  factory PostServiceDto.fromJson(Map<String, dynamic> json) => _$PostServiceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostServiceDtoToJson(this);
}
