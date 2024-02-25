import 'package:app/api/marketplace/enum/pricing_option.dart';
import 'package:app/api/user/model/brief_user_info_model.dart';

abstract class PublicationModel {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final PricingOption pricingOption;
  final double? price;
  final String category;
  final String createdAt;
  final bool amIPublisher;
  final BriefUserInfoModel publisher;

  PublicationModel(
    this.id,
    this.title,
    this.description,
    this.images,
    this.pricingOption,
    this.price,
    this.category,
    this.createdAt,
    this.amIPublisher,
    this.publisher,
  );
}
