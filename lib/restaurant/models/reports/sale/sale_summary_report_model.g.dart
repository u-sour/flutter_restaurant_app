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
    SaleSummaryReportModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('depName', instance.depName);
  writeNotNull('totalSale', instance.totalSale?.toJson());
  writeNotNull('openSale', instance.openSale?.toJson());
  writeNotNull('partialSale', instance.partialSale?.toJson());
  writeNotNull('receivedSale', instance.receivedSale?.toJson());
  return val;
}
