// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_summary_status_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleSummaryStatusReportModel _$SaleSummaryStatusReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleSummaryStatusReportModel(
      count: json['count'] as num,
      total: json['total'] as num,
      invoiceIds: json['invoiceIds'] as String?,
      totalDoc: ReportExchangeModel.fromJson(
          json['totalDoc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleSummaryStatusReportModelToJson(
        SaleSummaryStatusReportModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'invoiceIds': instance.invoiceIds,
      'totalDoc': instance.totalDoc.toJson(),
    };
