// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_invoice_to_kitchen_for_print_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailInvoiceToKitchenForPrintModel
    _$SaleDetailInvoiceToKitchenForPrintModelFromJson(
        Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleDetailInvoiceToKitchenForPrintModel(
    id: json['_id'] as String,
    itemId: json['itemId'] as String,
    itemName: json['itemName'] as String,
    showCategory: json['showCategory'] as bool,
    category: json['category'] as String,
    qty: json['qty'] as num,
    price: json['price'] as num,
    discount: json['discount'] as num,
    amount: json['amount'] as num,
    note: json['note'] as String?,
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

Map<String, dynamic> _$SaleDetailInvoiceToKitchenForPrintModelToJson(
        SaleDetailInvoiceToKitchenForPrintModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'showCategory': instance.showCategory,
      'category': instance.category,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
      'note': instance.note,
      'extraItems': instance.extraItems.map((e) => e.toJson()).toList(),
      'comboItems': instance.comboItems.map((e) => e.toJson()).toList(),
    };
