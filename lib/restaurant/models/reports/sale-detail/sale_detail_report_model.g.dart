// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailReportModel _$SaleDetailReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleDetailReportModel(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              SaleDetailDataReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      qty: json['qty'] as num,
      discountAmount: json['discountAmount'] as num,
      amount: json['amount'] as num,
      totalDoc: ReportExchangeModel.fromJson(
          json['totalDoc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleDetailReportModelToJson(
        SaleDetailReportModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'qty': instance.qty,
      'discountAmount': instance.discountAmount,
      'amount': instance.amount,
      'totalDoc': instance.totalDoc.toJson(),
    };
