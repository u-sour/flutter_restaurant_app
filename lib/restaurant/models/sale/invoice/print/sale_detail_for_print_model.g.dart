// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_for_print_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailForPrintModel _$SaleDetailForPrintModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleDetailForPrintModel(
    id: json['_id'] as String,
    itemName: json['itemName'] as String,
    showCategory: json['showCategory'] as bool,
    categoryName: json['categoryName'] as String,
    qty: json['qty'] as num,
    price: json['price'] as num,
    discount: json['discount'] as num,
    amount: json['amount'] as num,
    extraItems: (json['extraItems'] as List<dynamic>?)
            ?.map((e) =>
                SaleDetailExtraItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    comboItems: (json['comboItems'] as List<dynamic>?)
            ?.map((e) =>
                SaleDetailComboItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$SaleDetailForPrintModelToJson(
        SaleDetailForPrintModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'itemName': instance.itemName,
      'showCategory': instance.showCategory,
      'categoryName': instance.categoryName,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
      'extraItems': instance.extraItems.map((e) => e.toJson()).toList(),
      'comboItems': instance.comboItems.map((e) => e.toJson()).toList(),
    };
