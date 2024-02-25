import 'package:app/api/marketplace/model/item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/get_publications_model.g.dart';

@JsonSerializable()
class GetPublicationsModel {
  final int totalItems;
  final int page;
  final int limit;
  final List<ItemModel> items;

  GetPublicationsModel(
    this.totalItems,
    this.page,
    this.limit,
    this.items,
  );

  factory GetPublicationsModel.fromJson(Map<String, dynamic> json) => _$GetPublicationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPublicationsModelToJson(this);
}
