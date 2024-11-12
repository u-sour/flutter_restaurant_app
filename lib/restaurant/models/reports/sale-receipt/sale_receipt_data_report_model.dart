import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/model_converter/date_model_converter.dart';
part 'sale_receipt_data_report_model.g.dart';

@JsonSerializable()
class SaleReceiptDataReportModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String invoiceId;
  final String guestName;
  final String employeeName;
  final String depName;
  final String paymentBy;
  final String orderNum;
  final String refNo;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final bool isInitial;
  final String? memo;
  final num receiveAmount;
  final num feeAmount;
  final num openAmount;
  final num remainingAmount;
  final String status;

  SaleReceiptDataReportModel({
    required this.id,
    required this.invoiceId,
    required this.guestName,
    required this.employeeName,
    required this.depName,
    required this.paymentBy,
    required this.orderNum,
    required this.refNo,
    required this.date,
    required this.isInitial,
    this.memo,
    required this.receiveAmount,
    required this.feeAmount,
    required this.openAmount,
    required this.remainingAmount,
    required this.status,
  });

  factory SaleReceiptDataReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleReceiptDataReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleReceiptDataReportModelToJson(this);
}
