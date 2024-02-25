import 'package:app/api/marketplace/enum/pricing_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/post_product_dto.g.dart';

@JsonSerializable()
class PostProductDto {
  final String title;
  final String description;
  final PricingOption pricingOption;
  final double? price;
  final String condition;
  final String category;

  PostProductDto(
    this.title,
    this.description,
    this.pricingOption,
    this.price,
    this.condition,
    this.category,
  );

  factory PostProductDto.fromJson(Map<String, dynamic> json) => _$PostProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostProductDtoToJson(this);
}
