// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleProductModel _$SaleProductModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleProductModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    code: json['code'] as String?,
    category: json['category'] as String?,
    groupId: json['groupId'] as String?,
    group: json['group'] as String?,
    price: json['price'] as num,
    type: json['type'] as String,
    photo: json['photo'] as String?,
    photoUrl: json['photoUrl'] as String?,
    catalogType: json['catalogType'] as String?,
    addOwnItem: json['addOwnItem'] as bool?,
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    barcode: json['barcode'] as String?,
    showCategory: json['showCategory'] as bool?,
    favorite: json['favorite'] as bool?,
    discount: (json['discount'] as num).toInt(),
    branchId: json['branchId'] as String,
    createdAt: DateModelConverter.convertDateTimeForModel(
        json['createdAt'] as DateTime),
    discountPrice: json['discountPrice'] as num?,
    variantCount: json['variantCount'] as num,
  );
}

Map<String, dynamic> _$SaleProductModelToJson(SaleProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'category': instance.category,
      'groupId': instance.groupId,
      'group': instance.group,
      'price': instance.price,
      'type': instance.type,
      'photo': instance.photo,
      'photoUrl': instance.photoUrl,
      'catalogType': instance.catalogType,
      'addOwnItem': instance.addOwnItem,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'barcode': instance.barcode,
      'showCategory': instance.showCategory,
      'favorite': instance.favorite,
      'discount': instance.discount,
      'branchId': instance.branchId,
      'createdAt':
          DateModelConverter.convertDateTimeForModel(instance.createdAt),
      'discountPrice': instance.discountPrice,
      'variantCount': instance.variantCount,
    };
