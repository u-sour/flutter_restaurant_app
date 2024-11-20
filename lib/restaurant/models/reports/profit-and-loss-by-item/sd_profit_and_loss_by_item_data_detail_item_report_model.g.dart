// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sd_profit_and_loss_by_item_data_detail_item_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDProfitAndLossByItemDataDetailItemReportModel
    _$SDProfitAndLossByItemDataDetailItemReportModelFromJson(
            Map<String, dynamic> json) =>
        SDProfitAndLossByItemDataDetailItemReportModel(
          tranDate: DateModelConverter.convertDateTimeForModel(
              json['tranDate'] as DateTime),
          qty: json['qty'] as num,
          cost: json['cost'] as num,
          costAmount: json['costAmount'] as num,
          price: json['price'] as num,
          priceBeforeDiscount: json['priceBeforeDiscount'] as num,
          discount: json['discount'] as num,
          amount: json['amount'] as num,
          profit: json['profit'] as num,
        );

Map<String, dynamic> _$SDProfitAndLossByItemDataDetailItemReportModelToJson(
        SDProfitAndLossByItemDataDetailItemReportModel instance) =>
    <String, dynamic>{
      'tranDate': DateModelConverter.convertDateTimeForModel(instance.tranDate),
      'qty': instance.qty,
      'cost': instance.cost,
      'costAmount': instance.costAmount,
      'price': instance.price,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'discount': instance.discount,
      'amount': instance.amount,
      'profit': instance.profit,
    };
