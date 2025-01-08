// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceActionModel _$SaleInvoiceActionModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleInvoiceActionModel(
    id: json['_id'] as String?,
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
    depId: json['depId'] as String,
    employeeId: json['employeeId'] as String,
    guestId: json['guestId'] as String,
    numOfGuest: (json['numOfGuest'] as num).toInt(),
    billed: (json['billed'] as num).toInt(),
    branchId: json['branchId'] as String,
  );
}

Map<String, dynamic> _$SaleInvoiceActionModelToJson(
        SaleInvoiceActionModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) '_id': value,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'type': instance.type,
      'status': instance.status,
      'statusDate': instance.statusDate.toJson(),
      'discountRate': instance.discountRate,
      'discountValue': instance.discountValue,
      'total': instance.total,
      'totalReceived': instance.totalReceived,
      'tableId': instance.tableId,
      'depId': instance.depId,
      'employeeId': instance.employeeId,
      'guestId': instance.guestId,
      'numOfGuest': instance.numOfGuest,
      'billed': instance.billed,
      'branchId': instance.branchId,
    };
