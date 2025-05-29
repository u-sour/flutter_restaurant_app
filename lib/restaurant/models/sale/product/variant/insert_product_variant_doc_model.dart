import 'package:json_annotation/json_annotation.dart';
part 'insert_product_variant_doc_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsertProductVariantDocModel {
  final String itemId;
  final num qty;
  final num price;
  final num discount;
  final num amount;
  final String status;
  final bool checkPrint;
  final String invoiceId;
  final String branchId;

  const InsertProductVariantDocModel({
    required this.itemId,
    required this.qty,
    required this.price,
    required this.discount,
    required this.amount,
    required this.status,
    required this.checkPrint,
    required this.invoiceId,
    required this.branchId,
  });

  factory InsertProductVariantDocModel.fromJson(Map<String, dynamic> json) =>
      _$InsertProductVariantDocModelFromJson(json);
  Map<String, dynamic> toJson() => _$InsertProductVariantDocModelToJson(this);
}
