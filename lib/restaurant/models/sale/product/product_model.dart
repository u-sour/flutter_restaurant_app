import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  final String productId;
  final int qty;
  final num cost;
  final num amount;

  const ProductModel({
    required this.productId,
    required this.qty,
    required this.cost,
    required this.amount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
