import 'package:json_annotation/json_annotation.dart';
import 'product_variant_list_model.dart';
part 'product_variant_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductVariantModel {
  final String optionName;
  final List<ProductVariantListModel> variantList;

  const ProductVariantModel(
      {required this.optionName, required this.variantList});

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantModelToJson(this);
}
