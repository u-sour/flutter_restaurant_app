// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_data_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDataReportModel _$SaleDataReportModelFromJson(Map<String, dynamic> json) =>
    SaleDataReportModel(
      id: json['_id'],
      groupLabel: json['groupLabel'] as String,
      date:
          DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
      employeeName: json['employeeName'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) =>
              SaleDataDetailReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: json['subTotal'] as num,
      discountValue: json['discountValue'] as num,
      total: json['total'] as num,
      totalReceived: json['totalReceived'] as num,
    );

Map<String, dynamic> _$SaleDataReportModelToJson(
        SaleDataReportModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'groupLabel': instance.groupLabel,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'employeeName': instance.employeeName,
      'details': instance.details.map((e) => e.toJson()).toList(),
      'subTotal': instance.subTotal,
      'discountValue': instance.discountValue,
      'total': instance.total,
      'totalReceived': instance.totalReceived,
    };
