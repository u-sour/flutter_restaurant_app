// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_summary_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleSummaryReportModel _$SaleSummaryReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleSummaryReportModel(
      depName: json['depName'] as String,
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
      'depName': instance.depName,
      'totalSale': instance.totalSale?.toJson(),
      'openSale': instance.openSale?.toJson(),
      'partialSale': instance.partialSale?.toJson(),
      'receivedSale': instance.receivedSale?.toJson(),
    };
