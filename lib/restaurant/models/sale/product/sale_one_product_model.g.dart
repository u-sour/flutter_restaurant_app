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

Map<String, dynamic> _$SaleOneProductModelToJson(SaleOneProductModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  val['categoryIds'] = instance.categoryIds;
  writeNotNull('category', instance.category);
  writeNotNull('groupId', instance.groupId);
  writeNotNull('group', instance.group);
  val['status'] = instance.status;
  val['cost'] = instance.cost;
  val['markupPer'] = instance.markupPer;
  val['markupVal'] = instance.markupVal;
  val['price'] = instance.price;
  val['type'] = instance.type;
  writeNotNull('photo', instance.photo);
  writeNotNull('photoUrl', instance.photoUrl);
  writeNotNull('catalogType', instance.catalogType);
  writeNotNull('addOwnItem', instance.addOwnItem);
  writeNotNull('products', instance.products?.map((e) => e.toJson()).toList());
  writeNotNull('barcode', instance.barcode);
  writeNotNull('showCategory', instance.showCategory);
  writeNotNull('favorite', instance.favorite);
  val['branchId'] = instance.branchId;
  val['createdAt'] =
      DateModelConverter.convertDateTimeForModel(instance.createdAt);
  return val;
}
