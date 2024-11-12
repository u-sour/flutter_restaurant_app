// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleReportModel _$SaleReportModelFromJson(Map<String, dynamic> json) =>
    SaleReportModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => SaleDataReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      grandSubTotal: json['grandSubTotal'] as num,
      grandDiscount: json['grandDiscount'] as num,
      grandTotal: json['grandTotal'] as num,
      grandTotalDoc: ReportExchangeModel.fromJson(
          json['grandTotalDoc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleReportModelToJson(SaleReportModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'grandSubTotal': instance.grandSubTotal,
      'grandDiscount': instance.grandDiscount,
      'grandTotal': instance.grandTotal,
      'grandTotalDoc': instance.grandTotalDoc.toJson(),
    };
