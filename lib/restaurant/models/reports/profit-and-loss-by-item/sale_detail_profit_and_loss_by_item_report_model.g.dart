// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_profit_and_loss_by_item_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailProfitAndLossByItemReportModel
    _$SaleDetailProfitAndLossByItemReportModelFromJson(
            Map<String, dynamic> json) =>
        SaleDetailProfitAndLossByItemReportModel(
          data: (json['data'] as List<dynamic>)
              .map((e) => SDProfitAndLossByItemDataReportModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          totalQty: json['totalQty'] as num,
          totalCost: json['totalCost'] as num,
          totalPrice: json['totalPrice'] as num,
          totalDiscountAmount: json['totalDiscountAmount'] as num,
          totalProfit: json['totalProfit'] as num,
          totalProfitDoc: ReportExchangeModel.fromJson(
              json['totalProfitDoc'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SaleDetailProfitAndLossByItemReportModelToJson(
        SaleDetailProfitAndLossByItemReportModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'totalQty': instance.totalQty,
      'totalCost': instance.totalCost,
      'totalPrice': instance.totalPrice,
      'totalDiscountAmount': instance.totalDiscountAmount,
      'totalProfit': instance.totalProfit,
      'totalProfitDoc': instance.totalProfitDoc.toJson(),
    };
