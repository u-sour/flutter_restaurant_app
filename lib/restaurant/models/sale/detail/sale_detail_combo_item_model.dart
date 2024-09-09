import 'package:json_annotation/json_annotation.dart';
part 'sale_detail_combo_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailComboItemModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String itemName;
  final num qty;

  const SaleDetailComboItemModel({
    required this.id,
    required this.itemName,
    required this.qty,
  });

  factory SaleDetailComboItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailComboItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDetailComboItemModelToJson(this);
}
