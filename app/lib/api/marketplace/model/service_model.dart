import 'package:app/api/marketplace/enum/index.dart';
import 'package:app/api/marketplace/model/publication_model.dart';
import 'package:app/api/user/model/brief_user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/service_model.g.dart';

@JsonSerializable()
class ServiceModel extends PublicationModel {
  final ServiceCategory category;

  ServiceModel(
    String id,
    String title,
    String description,
    List<String> images,
    PricingOption pricingOption,
    double? price,
    String createdAt,
    bool amIPublisher,
    BriefUserInfoModel publisher,
    this.category
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

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
