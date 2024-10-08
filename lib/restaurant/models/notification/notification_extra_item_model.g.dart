// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_extra_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationExtraItemModel _$NotificationExtraItemModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return NotificationExtraItemModel(
    id: json['_id'] as String,
    itemId: json['itemId'] as String,
    itemName: json['itemName'] as String,
    price: json['price'] as num,
    discount: json['discount'] as num,
    amount: json['amount'] as num,
  );
}

Map<String, dynamic> _$NotificationExtraItemModelToJson(
        NotificationExtraItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
    };
