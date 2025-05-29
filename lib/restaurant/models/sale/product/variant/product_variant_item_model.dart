import 'package:json_annotation/json_annotation.dart';
part 'product_variant_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductVariantItemModel {
  final String name;
  final num price;
  num qty;
  final num discount;
  final num discountPrice;
  final String productId;
  final String variantId;

  ProductVariantItemModel({
    required this.name,
    required this.price,
    required this.qty,
    required this.discount,
    required this.discountPrice,
    required this.productId,
    required this.variantId,
  });

  factory ProductVariantItemModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantItemModelToJson(this);
}
