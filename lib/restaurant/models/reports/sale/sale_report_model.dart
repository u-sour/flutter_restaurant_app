import 'package:json_annotation/json_annotation.dart';
import '../report_exchange_model.dart';
import 'sale_data_report_model.dart';
part 'sale_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleReportModel {
  final List<SaleDataReportModel> data;
  final num grandSubTotal;
  final num grandDiscount;
  final num grandTotal;
  final ReportExchangeModel grandTotalDoc;

  const SaleReportModel(
      {required this.data,
      required this.grandSubTotal,
      required this.grandDiscount,
      required this.grandTotal,
      required this.grandTotalDoc});

  factory SaleReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleReportModelToJson(this);
}
