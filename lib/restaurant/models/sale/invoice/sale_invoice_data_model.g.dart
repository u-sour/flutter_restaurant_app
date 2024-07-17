// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceDataModel _$SaleInvoiceDataModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleInvoiceDataModel(
    id: json['_id'] as String,
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    type: json['type'] as String,
    status: json['status'] as String,
    statusDate: SaleInvoiceStatusDateModel.fromJson(
        json['statusDate'] as Map<String, dynamic>),
    discountRate: json['discountRate'] as num,
    discountValue: json['discountValue'] as num,
    total: json['total'] as num,
    totalReceived: json['totalReceived'] as num,
    tableId: json['tableId'] as String,
    employeeId: json['employeeId'] as String,
    guestId: json['guestId'] as String,
    numOfGuest: (json['numOfGuest'] as num).toInt(),
    billed: (json['billed'] as num).toInt(),
    guestName: json['guestName'] as String,
    tableName: json['tableName'] as String,
    orderNum: json['orderNum'] as String,
    refNo: json['refNo'] as String,
    branchId: json['branchId'] as String,
    receiptId: json['receiptId'] as bool,
    requestPayment: json['requestPayment'] as bool?,
  );
}

Map<String, dynamic> _$SaleInvoiceDataModelToJson(
        SaleInvoiceDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'type': instance.type,
      'status': instance.status,
      'statusDate': instance.statusDate.toJson(),
      'discountRate': instance.discountRate,
      'discountValue': instance.discountValue,
      'total': instance.total,
      'totalReceived': instance.totalReceived,
      'tableId': instance.tableId,
      'employeeId': instance.employeeId,
      'guestId': instance.guestId,
      'numOfGuest': instance.numOfGuest,
      'billed': instance.billed,
      'guestName': instance.guestName,
      'tableName': instance.tableName,
      'orderNum': instance.orderNum,
      'refNo': instance.refNo,
      'branchId': instance.branchId,
      'receiptId': instance.receiptId,
      'requestPayment': instance.requestPayment,
    };
