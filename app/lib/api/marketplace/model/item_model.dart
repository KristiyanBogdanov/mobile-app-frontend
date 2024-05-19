import 'package:app/api/marketplace/enum/publication_type.dart';
import 'package:app/api/marketplace/model/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/item_model.g.dart';

@JsonSerializable()
class ItemModel {
  final PublicationType type;
  final Object data;

  ItemModel(
    this.type,
    this.data,
  );

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
