// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_extra_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailExtraItemModel _$SaleDetailExtraItemModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleDetailExtraItemModel(
    id: json['_id'] as String,
    itemId: json['itemId'] as String,
    itemName: json['itemName'] as String,
    qty: json['qty'] as num,
    price: json['price'] as num,
    discount: json['discount'] as num,
    amount: json['amount'] as num,
    invoiceId: json['invoiceId'] as String,
  );
}

Map<String, dynamic> _$SaleDetailExtraItemModelToJson(
        SaleDetailExtraItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
      'invoiceId': instance.invoiceId,
    };
