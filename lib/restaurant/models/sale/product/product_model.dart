import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  final String productId;
  final String? variantId;
  final int qty;
  final num cost;
  final num amount;
  final num? discount;
  final num? discountPrice;
  final bool? draft;

  const ProductModel({
    required this.productId,
    this.variantId,
    required this.qty,
    required this.cost,
    required this.amount,
    this.discount,
    this.discountPrice,
    this.draft,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
