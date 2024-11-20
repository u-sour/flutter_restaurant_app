import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'sd_profit_and_loss_by_item_data_detail_item_report_model.dart';
part 'sd_profit_and_loss_by_item_data_detail_report_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SDProfitAndLossByItemDataDetailReportModel {
  // Noted: for looping into table
  final String? depName;
  final List<String> categoryNames;
  final String itemName;
  // Noted: for looping into table
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeOptionalForModel,
      toJson: DateModelConverter.convertDateTimeOptionalForModel)
  final DateTime? itemTranDate;
  final List<SDProfitAndLossByItemDataDetailItemReportModel> items;
  final num totalQty;
  final num totalCost;
  final num totalCostAmount;
  final num totalPrice;
  final num totalPriceAmount;
  final num totalDiscountAmount;
  final num totalPriceBeforeDiscount;
  final num totalProfit;
  // Noted: for looping into table
  final String? rowType;

  const SDProfitAndLossByItemDataDetailReportModel({
    this.depName,
    required this.categoryNames,
    required this.itemName,
    this.itemTranDate,
    required this.items,
    required this.totalQty,
    required this.totalCost,
    required this.totalCostAmount,
    required this.totalPrice,
    required this.totalPriceAmount,
    required this.totalDiscountAmount,
    required this.totalPriceBeforeDiscount,
    required this.totalProfit,
    this.rowType,
  });

  factory SDProfitAndLossByItemDataDetailReportModel.fromJson(
          Map<String, dynamic> json) =>
      _$SDProfitAndLossByItemDataDetailReportModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SDProfitAndLossByItemDataDetailReportModelToJson(this);
}
