import 'package:json_annotation/json_annotation.dart';
import '../../detail/sale_detail_combo_item_model.dart';
import '../../detail/sale_detail_extra_item_model.dart';
part 'sale_detail_for_print_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailForPrintModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String itemName;
  final bool showCategory;
  final String categoryName;
  num qty;
  num price;
  num discount;
  num amount;
  @JsonKey(defaultValue: [])
  final List<SaleDetailExtraItemModel> extraItems;
  @JsonKey(defaultValue: [])
  final List<SaleDetailComboItemModel> comboItems;

  SaleDetailForPrintModel({
    required this.id,
    required this.itemName,
    required this.showCategory,
    required this.categoryName,
    required this.qty,
    required this.price,
    required this.discount,
    required this.amount,
    required this.extraItems,
    required this.comboItems,
  });

  factory SaleDetailForPrintModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailForPrintModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDetailForPrintModelToJson(this);
}
