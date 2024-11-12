// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_receipt_data_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleReceiptDataReportModel _$SaleReceiptDataReportModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleReceiptDataReportModel(
    id: json['_id'] as String,
    invoiceId: json['invoiceId'] as String,
    guestName: json['guestName'] as String,
    employeeName: json['employeeName'] as String,
    depName: json['depName'] as String,
    paymentBy: json['paymentBy'] as String,
    orderNum: json['orderNum'] as String,
    refNo: json['refNo'] as String,
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    isInitial: json['isInitial'] as bool,
    memo: json['memo'] as String?,
    receiveAmount: json['receiveAmount'] as num,
    feeAmount: json['feeAmount'] as num,
    openAmount: json['openAmount'] as num,
    remainingAmount: json['remainingAmount'] as num,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$SaleReceiptDataReportModelToJson(
        SaleReceiptDataReportModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'invoiceId': instance.invoiceId,
      'guestName': instance.guestName,
      'employeeName': instance.employeeName,
      'depName': instance.depName,
      'paymentBy': instance.paymentBy,
      'orderNum': instance.orderNum,
      'refNo': instance.refNo,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'isInitial': instance.isInitial,
      'memo': instance.memo,
      'receiveAmount': instance.receiveAmount,
      'feeAmount': instance.feeAmount,
      'openAmount': instance.openAmount,
      'remainingAmount': instance.remainingAmount,
      'status': instance.status,
    };
