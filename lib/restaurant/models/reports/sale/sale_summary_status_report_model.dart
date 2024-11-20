import 'package:json_annotation/json_annotation.dart';
import '../report_exchange_model.dart';
part 'sale_summary_status_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleSummaryStatusReportModel {
  final num count;
  final num total;
  final String? invoiceIds;
  final ReportExchangeModel totalDoc;
  const SaleSummaryStatusReportModel({
    required this.count,
    required this.total,
    this.invoiceIds,
    required this.totalDoc,
  });

  factory SaleSummaryStatusReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleSummaryStatusReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleSummaryStatusReportModelToJson(this);
}
