import 'package:json_annotation/json_annotation.dart';
import 'sd_profit_and_loss_by_item_data_detail_report_model.dart';
part 'sd_profit_and_loss_by_item_data_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SDProfitAndLossByItemDataReportModel {
  final String depName;
  final List<SDProfitAndLossByItemDataDetailReportModel> details;
  final num grandTotalQty;
  final num grandTotalCostAmount;
  final num grandTotalPriceBeforeDiscount;
  final num grandTotalDiscountAmount;
  final num grandTotalPriceAmount;
  final num grandTotalProfit;

  const SDProfitAndLossByItemDataReportModel({
    required this.depName,
    required this.details,
    required this.grandTotalQty,
    required this.grandTotalCostAmount,
    required this.grandTotalPriceBeforeDiscount,
    required this.grandTotalDiscountAmount,
    required this.grandTotalPriceAmount,
    required this.grandTotalProfit,
  });

  factory SDProfitAndLossByItemDataReportModel.fromJson(
          Map<String, dynamic> json) =>
      _$SDProfitAndLossByItemDataReportModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SDProfitAndLossByItemDataReportModelToJson(this);
}
