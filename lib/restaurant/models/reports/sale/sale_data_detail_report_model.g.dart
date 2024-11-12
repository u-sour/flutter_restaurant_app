// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_data_detail_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDataDetailReportModel _$SaleDataDetailReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleDataDetailReportModel(
      groupLabel: json['groupLabel'] as String?,
      no: (json['no'] as num?)?.toInt(),
      orderNum: json['orderNum'] as String,
      refNo: json['refNo'] as String,
      date:
          DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
      outDate: DateModelConverter.convertDateTimeOptionalForModel(
          json['outDate'] as DateTime?),
      type: json['type'] as String,
      status: json['status'] as String,
      discountRate: json['discountRate'] as num,
      discountValue: json['discountValue'] as num,
      subTotal: json['subTotal'] as num,
      total: json['total'] as num,
      totalReceived: json['totalReceived'] as num,
      tableName: json['tableName'] as String,
      floorName: json['floorName'] as String,
      employeeName: json['employeeName'] as String,
      guestName: json['guestName'] as String,
      depName: json['depName'] as String,
      isCancel: json['isCancel'] as bool,
      refId: json['refId'] as String?,
      refDoc: json['refDoc'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SaleDataDetailReportModelToJson(
        SaleDataDetailReportModel instance) =>
    <String, dynamic>{
      'groupLabel': instance.groupLabel,
      'no': instance.no,
      'orderNum': instance.orderNum,
      'refNo': instance.refNo,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'outDate':
          DateModelConverter.convertDateTimeOptionalForModel(instance.outDate),
      'type': instance.type,
      'status': instance.status,
      'discountRate': instance.discountRate,
      'discountValue': instance.discountValue,
      'subTotal': instance.subTotal,
      'total': instance.total,
      'totalReceived': instance.totalReceived,
      'tableName': instance.tableName,
      'floorName': instance.floorName,
      'employeeName': instance.employeeName,
      'guestName': instance.guestName,
      'depName': instance.depName,
      'isCancel': instance.isCancel,
      'refId': instance.refId,
      'refDoc': instance.refDoc,
    };
