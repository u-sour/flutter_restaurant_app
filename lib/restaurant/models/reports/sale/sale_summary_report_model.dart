import 'package:json_annotation/json_annotation.dart';
import 'sale_summary_status_report_model.dart';
part 'sale_summary_report_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SaleSummaryReportModel {
  final String? depName;
  final SaleSummaryStatusReportModel? totalSale;
  final SaleSummaryStatusReportModel? openSale;
  final SaleSummaryStatusReportModel? partialSale;
  final SaleSummaryStatusReportModel? receivedSale;

  const SaleSummaryReportModel({
    this.depName,
    this.totalSale,
    this.openSale,
    this.partialSale,
    this.receivedSale,
  });

  factory SaleSummaryReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleSummaryReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleSummaryReportModelToJson(this);
}
