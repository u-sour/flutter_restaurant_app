import 'package:json_annotation/json_annotation.dart';
import '../../../../../utils/model_converter/date_model_converter.dart';
part 'sale_receipt_for_print_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleReceiptForPrintModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String paymentBy;
  final num receiveAmount;
  final num feeAmount;
  final num? prevReceiveAmount;
  final num? prevFeeAmount;
  final num openAmount;
  final bool? isInitial;

  const SaleReceiptForPrintModel({
    required this.id,
    required this.date,
    required this.paymentBy,
    required this.receiveAmount,
    required this.feeAmount,
    this.prevReceiveAmount,
    this.prevFeeAmount,
    required this.openAmount,
    this.isInitial,
  });

  factory SaleReceiptForPrintModel.fromJson(Map<String, dynamic> json) =>
      _$SaleReceiptForPrintModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleReceiptForPrintModelToJson(this);
}
