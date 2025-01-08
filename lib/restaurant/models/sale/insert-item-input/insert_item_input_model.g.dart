// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_item_input_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertItemInputModel _$InsertItemInputModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['draft'],
  );
  return InsertItemInputModel(
    itemId: json['itemId'] as String,
    itemName: json['itemName'] as String?,
    qty: json['qty'] as num,
    price: json['price'] as num,
    discount: json['discount'] as num,
    amount: json['amount'] as num,
    status: json['status'] as String,
    invoiceId: json['invoiceId'] as String,
    checkPrint: json['checkPrint'] as bool,
    draft: json['draft'] as bool?,
    branchId: json['branchId'] as String,
  );
}

Map<String, dynamic> _$InsertItemInputModelToJson(
        InsertItemInputModel instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
      'status': instance.status,
      'invoiceId': instance.invoiceId,
      'checkPrint': instance.checkPrint,
      if (instance.draft case final value?) 'draft': value,
      'branchId': instance.branchId,
    };
