import 'package:json_annotation/json_annotation.dart';
import '../report_exchange_model.dart';
import 'sale_detail_data_report_model.dart';
part 'sale_detail_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailReportModel {
  final List<SaleDetailDataReportModel> data;
  final num qty;
  final num discountAmount;
  final num amount;
  final ReportExchangeModel totalDoc;

  const SaleDetailReportModel({
    required this.data,
    required this.qty,
    required this.discountAmount,
    required this.amount,
    required this.totalDoc,
  });

  factory SaleDetailReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDetailReportModelToJson(this);
}
