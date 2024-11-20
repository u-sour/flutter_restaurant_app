// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sd_profit_and_loss_by_item_data_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDProfitAndLossByItemDataReportModel
    _$SDProfitAndLossByItemDataReportModelFromJson(Map<String, dynamic> json) =>
        SDProfitAndLossByItemDataReportModel(
          depName: json['depName'] as String,
          details: (json['details'] as List<dynamic>)
              .map((e) => SDProfitAndLossByItemDataDetailReportModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          grandTotalQty: json['grandTotalQty'] as num,
          grandTotalCostAmount: json['grandTotalCostAmount'] as num,
          grandTotalPriceBeforeDiscount:
              json['grandTotalPriceBeforeDiscount'] as num,
          grandTotalDiscountAmount: json['grandTotalDiscountAmount'] as num,
          grandTotalPriceAmount: json['grandTotalPriceAmount'] as num,
          grandTotalProfit: json['grandTotalProfit'] as num,
        );

Map<String, dynamic> _$SDProfitAndLossByItemDataReportModelToJson(
        SDProfitAndLossByItemDataReportModel instance) =>
    <String, dynamic>{
      'depName': instance.depName,
      'details': instance.details.map((e) => e.toJson()).toList(),
      'grandTotalQty': instance.grandTotalQty,
      'grandTotalCostAmount': instance.grandTotalCostAmount,
      'grandTotalPriceBeforeDiscount': instance.grandTotalPriceBeforeDiscount,
      'grandTotalDiscountAmount': instance.grandTotalDiscountAmount,
      'grandTotalPriceAmount': instance.grandTotalPriceAmount,
      'grandTotalProfit': instance.grandTotalProfit,
    };
