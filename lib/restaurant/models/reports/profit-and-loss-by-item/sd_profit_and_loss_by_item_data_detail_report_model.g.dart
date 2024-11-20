// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sd_profit_and_loss_by_item_data_detail_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDProfitAndLossByItemDataDetailReportModel
    _$SDProfitAndLossByItemDataDetailReportModelFromJson(
            Map<String, dynamic> json) =>
        SDProfitAndLossByItemDataDetailReportModel(
          depName: json['depName'] as String?,
          categoryNames: (json['categoryNames'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          itemName: json['itemName'] as String,
          itemTranDate: DateModelConverter.convertDateTimeOptionalForModel(
              json['itemTranDate'] as DateTime?),
          items: (json['items'] as List<dynamic>)
              .map((e) =>
                  SDProfitAndLossByItemDataDetailItemReportModel.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
          totalQty: json['totalQty'] as num,
          totalCost: json['totalCost'] as num,
          totalCostAmount: json['totalCostAmount'] as num,
          totalPrice: json['totalPrice'] as num,
          totalPriceAmount: json['totalPriceAmount'] as num,
          totalDiscountAmount: json['totalDiscountAmount'] as num,
          totalPriceBeforeDiscount: json['totalPriceBeforeDiscount'] as num,
          totalProfit: json['totalProfit'] as num,
          rowType: json['rowType'] as String?,
        );

Map<String, dynamic> _$SDProfitAndLossByItemDataDetailReportModelToJson(
    SDProfitAndLossByItemDataDetailReportModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('depName', instance.depName);
  val['categoryNames'] = instance.categoryNames;
  val['itemName'] = instance.itemName;
  writeNotNull(
      'itemTranDate',
      DateModelConverter.convertDateTimeOptionalForModel(
          instance.itemTranDate));
  val['items'] = instance.items.map((e) => e.toJson()).toList();
  val['totalQty'] = instance.totalQty;
  val['totalCost'] = instance.totalCost;
  val['totalCostAmount'] = instance.totalCostAmount;
  val['totalPrice'] = instance.totalPrice;
  val['totalPriceAmount'] = instance.totalPriceAmount;
  val['totalDiscountAmount'] = instance.totalDiscountAmount;
  val['totalPriceBeforeDiscount'] = instance.totalPriceBeforeDiscount;
  val['totalProfit'] = instance.totalProfit;
  writeNotNull('rowType', instance.rowType);
  return val;
}
