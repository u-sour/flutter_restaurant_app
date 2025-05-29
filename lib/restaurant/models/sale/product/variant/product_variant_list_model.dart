import 'package:json_annotation/json_annotation.dart';
import 'product_variant_item_model.dart';
part 'product_variant_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductVariantListModel {
  final String label;
  final String value;
  final List<ProductVariantItemModel> items;

  const ProductVariantListModel(
      {required this.label, required this.value, required this.items});

  factory ProductVariantListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantListModelToJson(this);
}
