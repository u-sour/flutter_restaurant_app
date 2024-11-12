// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_receipt_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleReceiptReportModel _$SaleReceiptReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleReceiptReportModel(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              SaleReceiptDataReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDoc: SaleReceiptTotalDocReportModel.fromJson(
          json['totalDoc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleReceiptReportModelToJson(
        SaleReceiptReportModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'totalDoc': instance.totalDoc.toJson(),
    };
