// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_sale_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditSaleReceiptModel _$EditSaleReceiptModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return EditSaleReceiptModel(
    id: json['_id'] as String,
    saleDate: DateModelConverter.convertDateTimeForModel(
        json['saleDate'] as DateTime),
    invoiceId: json['invoiceId'] as String,
    orderNum: json['orderNum'] as String,
    refNo: json['refNo'] as String,
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    memo: json['memo'] as String?,
    guestId: json['guestId'] as String,
    guestName: json['guestName'] as String,
    branchId: json['branchId'] as String,
    openAmount: json['openAmount'] as num,
  );
}

Map<String, dynamic> _$EditSaleReceiptModelToJson(
        EditSaleReceiptModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'saleDate': DateModelConverter.convertDateTimeForModel(instance.saleDate),
      'invoiceId': instance.invoiceId,
      'orderNum': instance.orderNum,
      'refNo': instance.refNo,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'memo': instance.memo,
      'guestId': instance.guestId,
      'guestName': instance.guestName,
      'branchId': instance.branchId,
      'openAmount': instance.openAmount,
    };
