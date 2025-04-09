// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_add_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleAddProductModel _$SaleAddProductModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleAddProductModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    cost: json['cost'] as num?,
    price: json['price'] as num,
    type: json['type'] as String?,
    photoUrl: json['photoUrl'] as String?,
    catalogType: json['catalogType'] as String?,
    addOwnItem: json['addOwnItem'] as bool?,
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    code: json['code'] as String?,
    barcode: json['barcode'] as String?,
    showCategory: json['showCategory'] as bool?,
    favorite: json['favorite'] as bool?,
    discount: json['discount'] as num,
    discountAmount: json['discountAmount'] as num?,
    checkPrintKitchen: json['checkPrintKitchen'] as bool?,
    branchId: json['branchId'] as String,
  );
}

Map<String, dynamic> _$SaleAddProductModelToJson(
        SaleAddProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'cost': instance.cost,
      'price': instance.price,
      'type': instance.type,
      'photoUrl': instance.photoUrl,
      'catalogType': instance.catalogType,
      'addOwnItem': instance.addOwnItem,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'code': instance.code,
      'barcode': instance.barcode,
      'showCategory': instance.showCategory,
      'favorite': instance.favorite,
      'discount': instance.discount,
      'discountAmount': instance.discountAmount,
      'checkPrintKitchen': instance.checkPrintKitchen,
      'branchId': instance.branchId,
    };
