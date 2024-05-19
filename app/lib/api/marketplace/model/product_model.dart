import 'package:app/api/marketplace/enum/index.dart';
import 'package:app/api/marketplace/model/publication_model.dart';
import 'package:app/api/user/model/brief_user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/product_model.g.dart';

@JsonSerializable()
class ProductModel extends PublicationModel {
  final ProductCondition condition;
  final ProductCategory category;

  ProductModel(
    String id,
    String title,
    String description,
    List<String> images,
    PricingOption pricingOption,
    double? price,
    String createdAt,
    bool amIPublisher,
    BriefUserInfoModel publisher,
    this.condition,
    this.category,
  ) : super(
          id,
          title,
          description,
          images,
          pricingOption,
          price,
          createdAt,
          amIPublisher,
          publisher,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
