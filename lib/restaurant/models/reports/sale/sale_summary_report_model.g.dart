// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_summary_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleSummaryReportModel _$SaleSummaryReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleSummaryReportModel(
      depName: json['depName'] as String?,
      totalSale: json['totalSale'] == null
          ? null
          : SaleSummaryStatusReportModel.fromJson(
              json['totalSale'] as Map<String, dynamic>),
      openSale: json['openSale'] == null
          ? null
          : SaleSummaryStatusReportModel.fromJson(
              json['openSale'] as Map<String, dynamic>),
      partialSale: json['partialSale'] == null
          ? null
          : SaleSummaryStatusReportModel.fromJson(
              json['partialSale'] as Map<String, dynamic>),
      receivedSale: json['receivedSale'] == null
          ? null
          : SaleSummaryStatusReportModel.fromJson(
              json['receivedSale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleSummaryReportModelToJson(
        SaleSummaryReportModel instance) =>
    <String, dynamic>{
      if (instance.depName case final value?) 'depName': value,
      if (instance.totalSale?.toJson() case final value?) 'totalSale': value,
      if (instance.openSale?.toJson() case final value?) 'openSale': value,
      if (instance.partialSale?.toJson() case final value?)
        'partialSale': value,
      if (instance.receivedSale?.toJson() case final value?)
        'receivedSale': value,
    };
