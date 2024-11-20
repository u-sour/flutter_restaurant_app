import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
part 'sd_profit_and_loss_by_item_data_detail_item_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SDProfitAndLossByItemDataDetailItemReportModel {
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime tranDate;
  final num qty;
  final num cost;
  final num costAmount;
  final num price;
  final num priceBeforeDiscount;
  final num discount;
  final num amount;
  final num profit;

  const SDProfitAndLossByItemDataDetailItemReportModel({
    required this.tranDate,
    required this.qty,
    required this.cost,
    required this.costAmount,
    required this.price,
    required this.priceBeforeDiscount,
    required this.discount,
    required this.amount,
    required this.profit,
  });

  factory SDProfitAndLossByItemDataDetailItemReportModel.fromJson(
          Map<String, dynamic> json) =>
      _$SDProfitAndLossByItemDataDetailItemReportModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SDProfitAndLossByItemDataDetailItemReportModelToJson(this);
}
