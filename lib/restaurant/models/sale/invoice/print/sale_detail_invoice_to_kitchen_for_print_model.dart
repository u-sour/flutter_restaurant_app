import 'package:json_annotation/json_annotation.dart';
import '../../detail/sale_detail_combo_item_model.dart';
import '../../detail/sale_detail_extra_item_model.dart';
part 'sale_detail_invoice_to_kitchen_for_print_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailInvoiceToKitchenForPrintModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String itemId;
  final String itemName;
  final bool showCategory;
  final String category;
  num qty;
  num price;
  num discount;
  num amount;
  String? note;
  @JsonKey(defaultValue: [])
  final List<SaleDetailExtraItemModel> extraItems;
  @JsonKey(defaultValue: [])
  final List<SaleDetailComboItemModel> comboItems;

  SaleDetailInvoiceToKitchenForPrintModel({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.showCategory,
    required this.category,
    required this.qty,
    required this.price,
    required this.discount,
    required this.amount,
    this.note,
    required this.extraItems,
    required this.comboItems,
  });

  factory SaleDetailInvoiceToKitchenForPrintModel.fromJson(
          Map<String, dynamic> json) =>
      _$SaleDetailInvoiceToKitchenForPrintModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SaleDetailInvoiceToKitchenForPrintModelToJson(this);
}
