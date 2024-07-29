import 'package:json_annotation/json_annotation.dart';
part 'sale_product_group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleProductGroupModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String name;

  const SaleProductGroupModel({
    required this.id,
    required this.name,
  });

  factory SaleProductGroupModel.fromJson(Map<String, dynamic> json) =>
      _$SaleProductGroupModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleProductGroupModelToJson(this);
}
