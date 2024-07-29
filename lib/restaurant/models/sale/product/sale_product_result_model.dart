import 'package:json_annotation/json_annotation.dart';
import 'sale_product_model.dart';
part 'sale_product_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleProductResultModel {
  final List<SaleProductModel> items;
  final int itemCount;

  const SaleProductResultModel({required this.items, required this.itemCount});

  factory SaleProductResultModel.fromJson(Map<String, dynamic> json) =>
      _$SaleProductResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleProductResultModelToJson(this);
}
