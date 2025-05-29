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
          categoryNames: json['categoryNames'] as String,
          itemName: json['itemName'] as String,
          variantId: json['variantId'] as String?,
          variantName: json['variantName'] as String?,
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
        SDProfitAndLossByItemDataDetailReportModel instance) =>
    <String, dynamic>{
      if (instance.depName case final value?) 'depName': value,
      'categoryNames': instance.categoryNames,
      'itemName': instance.itemName,
      if (instance.variantId case final value?) 'variantId': value,
      if (instance.variantName case final value?) 'variantName': value,
      if (DateModelConverter.convertDateTimeOptionalForModel(
              instance.itemTranDate)
          case final value?)
        'itemTranDate': value,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'totalQty': instance.totalQty,
      'totalCost': instance.totalCost,
      'totalCostAmount': instance.totalCostAmount,
      'totalPrice': instance.totalPrice,
      'totalPriceAmount': instance.totalPriceAmount,
      'totalDiscountAmount': instance.totalDiscountAmount,
      'totalPriceBeforeDiscount': instance.totalPriceBeforeDiscount,
      'totalProfit': instance.totalProfit,
      if (instance.rowType case final value?) 'rowType': value,
    };
