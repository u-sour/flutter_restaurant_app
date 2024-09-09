import 'package:json_annotation/json_annotation.dart';
part 'insert_item_input_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsertItemInputModel {
  final String itemId;
  final String? itemName;
  final num qty;
  final num price;
  final num discount;
  final num amount;
  final String status;
  final String invoiceId;
  final bool checkPrint;
  @JsonKey(disallowNullValue: true)
  final bool? draft;
  final String branchId;

  const InsertItemInputModel({
    required this.itemId,
    this.itemName,
    required this.qty,
    required this.price,
    required this.discount,
    required this.amount,
    required this.status,
    required this.invoiceId,
    required this.checkPrint,
    this.draft,
    required this.branchId,
  });
  factory InsertItemInputModel.fromJson(Map<String, dynamic> json) =>
      _$InsertItemInputModelFromJson(json);
  Map<String, dynamic> toJson() => _$InsertItemInputModelToJson(this);
}
