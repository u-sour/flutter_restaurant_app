import 'package:json_annotation/json_annotation.dart';
part 'insert_product_variant_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsertProductVariantModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final num qty;
  final num price;
  final num discount;

  const InsertProductVariantModel({
    required this.id,
    required this.qty,
    required this.price,
    required this.discount,
  });

  factory InsertProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$InsertProductVariantModelFromJson(json);
  Map<String, dynamic> toJson() => _$InsertProductVariantModelToJson(this);
}
