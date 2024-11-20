import 'package:json_annotation/json_annotation.dart';
import '../report_exchange_model.dart';
import 'sd_profit_and_loss_by_item_data_report_model.dart';
part 'sale_detail_profit_and_loss_by_item_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailProfitAndLossByItemReportModel {
  final List<SDProfitAndLossByItemDataReportModel> data;
  final num totalQty;
  final num totalCost;
  final num totalPrice;
  final num totalDiscountAmount;
  final num totalProfit;
  final ReportExchangeModel totalProfitDoc;

  const SaleDetailProfitAndLossByItemReportModel({
    required this.data,
    required this.totalQty,
    required this.totalCost,
    required this.totalPrice,
    required this.totalDiscountAmount,
    required this.totalProfit,
    required this.totalProfitDoc,
  });

  factory SaleDetailProfitAndLossByItemReportModel.fromJson(
          Map<String, dynamic> json) =>
      _$SaleDetailProfitAndLossByItemReportModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SaleDetailProfitAndLossByItemReportModelToJson(this);
}
