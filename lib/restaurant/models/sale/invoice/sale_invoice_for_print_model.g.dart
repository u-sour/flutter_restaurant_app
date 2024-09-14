// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_for_print_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceForPrintModel _$SaleInvoiceForPrintModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleInvoiceForPrintModel(
    id: json['_id'] as String,
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    status: json['status'] as String,
    discountRate: json['discountRate'] as num,
    discountValue: json['discountValue'] as num,
    total: json['total'] as num,
    totalReceived: json['totalReceived'] as num,
    tableId: json['tableId'] as String,
    guestName: json['guestName'] as String,
    employeeName: json['employeeName'] as String,
    tableName: json['tableName'] as String,
    floorName: json['floorName'] as String,
    orderNum: json['orderNum'] as String,
    refNo: json['refNo'] as String,
  );
}

Map<String, dynamic> _$SaleInvoiceForPrintModelToJson(
        SaleInvoiceForPrintModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'status': instance.status,
      'discountRate': instance.discountRate,
      'discountValue': instance.discountValue,
      'total': instance.total,
      'totalReceived': instance.totalReceived,
      'tableId': instance.tableId,
      'guestName': instance.guestName,
      'employeeName': instance.employeeName,
      'tableName': instance.tableName,
      'floorName': instance.floorName,
      'orderNum': instance.orderNum,
      'refNo': instance.refNo,
    };
