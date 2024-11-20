import 'package:json_annotation/json_annotation.dart';
import '../report_exchange_model.dart';
part 'sale_receipt_total_doc_report_model.g.dart';

@JsonSerializable()
class SaleReceiptTotalDocReportModel {
  final num openAmount;
  final ReportExchangeModel openAmountDoc;
  final num receiveAmount;
  final ReportExchangeModel receiveAmountDoc;
  final num feeAmount;
  final ReportExchangeModel feeAmountDoc;
  final num remainingAmount;
  final ReportExchangeModel remainingAmountDoc;

  const SaleReceiptTotalDocReportModel({
    required this.openAmount,
    required this.openAmountDoc,
    required this.receiveAmount,
    required this.receiveAmountDoc,
    required this.feeAmount,
    required this.feeAmountDoc,
    required this.remainingAmount,
    required this.remainingAmountDoc,
  });

  factory SaleReceiptTotalDocReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleReceiptTotalDocReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleReceiptTotalDocReportModelToJson(this);
}
