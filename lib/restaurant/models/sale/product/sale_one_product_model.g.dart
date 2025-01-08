// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_one_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleOneProductModel _$SaleOneProductModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleOneProductModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    code: json['code'] as String?,
    categoryIds:
        (json['categoryIds'] as List<dynamic>).map((e) => e as String).toList(),
    category: json['category'] as String?,
    groupId: json['groupId'] as String?,
    group: json['group'] as String?,
    status: json['status'] as String,
    cost: json['cost'] as num,
    markupPer: json['markupPer'] as num,
    markupVal: json['markupVal'] as num,
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
    branchId: json['branchId'] as String,
    createdAt: DateModelConverter.convertDateTimeForModel(
        json['createdAt'] as DateTime),
  );
}

Map<String, dynamic> _$SaleOneProductModelToJson(
        SaleOneProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      if (instance.code case final value?) 'code': value,
      'categoryIds': instance.categoryIds,
      if (instance.category case final value?) 'category': value,
      if (instance.groupId case final value?) 'groupId': value,
      if (instance.group case final value?) 'group': value,
      'status': instance.status,
      'cost': instance.cost,
      'markupPer': instance.markupPer,
      'markupVal': instance.markupVal,
      'price': instance.price,
      'type': instance.type,
      if (instance.photo case final value?) 'photo': value,
      if (instance.photoUrl case final value?) 'photoUrl': value,
      if (instance.catalogType case final value?) 'catalogType': value,
      if (instance.addOwnItem case final value?) 'addOwnItem': value,
      if (instance.products?.map((e) => e.toJson()).toList() case final value?)
        'products': value,
      if (instance.barcode case final value?) 'barcode': value,
      if (instance.showCategory case final value?) 'showCategory': value,
      if (instance.favorite case final value?) 'favorite': value,
      'branchId': instance.branchId,
      'createdAt':
          DateModelConverter.convertDateTimeForModel(instance.createdAt),
    };
