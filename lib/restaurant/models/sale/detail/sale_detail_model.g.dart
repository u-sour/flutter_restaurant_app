// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailModel _$SaleDetailModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id', 'draft'],
  );
  return SaleDetailModel(
    id: json['_id'] as String,
    invoiceId: json['invoiceId'] as String,
    itemId: json['itemId'] as String,
    itemName: json['itemName'] as String,
    catalogType: json['catalogType'] as String?,
    showCategory: json['showCategory'] as bool?,
    category: json['category'] as String,
    group: json['group'] as String?,
    qty: json['qty'] as num,
    returnQty: json['returnQty'] as num,
    totalQty: json['totalQty'] as num,
    price: json['price'] as num,
    status: json['status'] as String,
    discount: json['discount'] as num,
    amount: json['amount'] as num,
    checkPrint: json['checkPrint'] as bool,
    note: json['note'] as String?,
    checkPrintKitchen: json['checkPrintKitchen'] as bool?,
    child: json['child'] as bool?,
    draft: json['draft'] as bool?,
    createdAt: DateModelConverter.convertDateTimeForModel(
        json['createdAt'] as DateTime),
    branchId: json['branchId'] as String,
    extraItemDoc: (json['extraItemDoc'] as List<dynamic>?)
            ?.map((e) =>
                SaleDetailExtraItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    comboDoc: (json['comboDoc'] as List<dynamic>?)
            ?.map((e) =>
                SaleDetailComboItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$SaleDetailModelToJson(SaleDetailModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'invoiceId': instance.invoiceId,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'catalogType': instance.catalogType,
      'showCategory': instance.showCategory,
      'category': instance.category,
      'group': instance.group,
      'qty': instance.qty,
      'returnQty': instance.returnQty,
      'totalQty': instance.totalQty,
      'price': instance.price,
      'status': instance.status,
      'discount': instance.discount,
      'amount': instance.amount,
      'checkPrint': instance.checkPrint,
      'note': instance.note,
      'checkPrintKitchen': instance.checkPrintKitchen,
      'child': instance.child,
      if (instance.draft case final value?) 'draft': value,
      'createdAt':
          DateModelConverter.convertDateTimeForModel(instance.createdAt),
      'branchId': instance.branchId,
      'extraItemDoc': instance.extraItemDoc.map((e) => e.toJson()).toList(),
      'comboDoc': instance.comboDoc.map((e) => e.toJson()).toList(),
    };
