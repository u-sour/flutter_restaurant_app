import 'package:json_annotation/json_annotation.dart';
import 'sale_receipt_data_report_model.dart';
import 'sale_receipt_total_doc_report_model.dart';
part 'sale_receipt_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleReceiptReportModel {
  final List<SaleReceiptDataReportModel> data;
  final SaleReceiptTotalDocReportModel totalDoc;

  SaleReceiptReportModel({
    required this.data,
    required this.totalDoc,
  });

  factory SaleReceiptReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleReceiptReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleReceiptReportModelToJson(this);
}
