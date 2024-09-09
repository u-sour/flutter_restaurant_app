import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'sale_detail_combo_item_model.dart';
import 'sale_detail_extra_item_model.dart';
part 'sale_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String invoiceId;
  final String itemId;
  final String itemName;
  final String? catalogType;
  final bool? showCategory;
  final String category;
  final String? group;
  num qty;
  num returnQty;
  num totalQty;
  num price;
  final String status;
  num discount;
  num amount;
  final bool checkPrint;
  String? note;
  final bool? checkPrintKitchen;
  final bool? child;
  @JsonKey(disallowNullValue: true)
  final bool? draft;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime createdAt;
  final String branchId;
  @JsonKey(defaultValue: [])
  final List<SaleDetailExtraItemModel> extraItemDoc;
  @JsonKey(defaultValue: [])
  final List<SaleDetailComboItemModel> comboDoc;

  SaleDetailModel({
    required this.id,
    required this.invoiceId,
    required this.itemId,
    required this.itemName,
    this.catalogType,
    this.showCategory,
    required this.category,
    this.group,
    required this.qty,
    required this.returnQty,
    required this.totalQty,
    required this.price,
    required this.status,
    required this.discount,
    required this.amount,
    required this.checkPrint,
    this.note,
    this.checkPrintKitchen,
    this.child,
    this.draft,
    required this.createdAt,
    required this.branchId,
    required this.extraItemDoc,
    required this.comboDoc,
  });

  factory SaleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDetailModelToJson(this);
}
