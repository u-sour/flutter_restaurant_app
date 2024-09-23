import 'package:json_annotation/json_annotation.dart';
part 'sale_detail_extra_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailExtraItemModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String? itemId;
  final String itemName;
  final num qty;
  final num price;
  num discount;
  num amount;
  final String invoiceId;

  SaleDetailExtraItemModel({
    required this.id,
    this.itemId,
    required this.itemName,
    required this.qty,
    required this.price,
    required this.discount,
    required this.amount,
    required this.invoiceId,
  });

  factory SaleDetailExtraItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailExtraItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDetailExtraItemModelToJson(this);
}
