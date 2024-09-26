import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
part 'edit_sale_receipt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EditSaleReceiptModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime saleDate;
  final String invoiceId;
  final String orderNum;
  final String refNo;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String? memo;
  final String guestId;
  final String guestName;
  final String branchId;
  final num openAmount;
  const EditSaleReceiptModel({
    required this.id,
    required this.saleDate,
    required this.invoiceId,
    required this.orderNum,
    required this.refNo,
    required this.date,
    this.memo,
    required this.guestId,
    required this.guestName,
    required this.branchId,
    required this.openAmount,
  });

  factory EditSaleReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$EditSaleReceiptModelFromJson(json);
  Map<String, dynamic> toJson() => _$EditSaleReceiptModelToJson(this);
}
