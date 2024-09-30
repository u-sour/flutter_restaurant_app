// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_receipt_for_print_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleReceiptForPrintModel _$SaleReceiptForPrintModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleReceiptForPrintModel(
    id: json['_id'] as String,
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    paymentBy: json['paymentBy'] as String?,
    receiveAmount: json['receiveAmount'] as num,
    feeAmount: json['feeAmount'] as num,
    prevReceiveAmount: json['prevReceiveAmount'] as num?,
    prevFeeAmount: json['prevFeeAmount'] as num?,
    openAmount: json['openAmount'] as num,
    isInitial: json['isInitial'] as bool?,
  );
}

Map<String, dynamic> _$SaleReceiptForPrintModelToJson(
        SaleReceiptForPrintModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'paymentBy': instance.paymentBy,
      'receiveAmount': instance.receiveAmount,
      'feeAmount': instance.feeAmount,
      'prevReceiveAmount': instance.prevReceiveAmount,
      'prevFeeAmount': instance.prevFeeAmount,
      'openAmount': instance.openAmount,
      'isInitial': instance.isInitial,
    };
