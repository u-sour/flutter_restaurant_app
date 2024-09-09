// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_combo_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailComboItemModel _$SaleDetailComboItemModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleDetailComboItemModel(
    id: json['_id'] as String,
    itemName: json['itemName'] as String,
    qty: json['qty'] as num,
  );
}

Map<String, dynamic> _$SaleDetailComboItemModelToJson(
        SaleDetailComboItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'itemName': instance.itemName,
      'qty': instance.qty,
    };
