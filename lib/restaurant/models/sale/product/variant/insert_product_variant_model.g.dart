// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertProductVariantModel _$InsertProductVariantModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return InsertProductVariantModel(
    id: json['_id'] as String,
    qty: json['qty'] as num,
    price: json['price'] as num,
    discount: json['discount'] as num,
  );
}

Map<String, dynamic> _$InsertProductVariantModelToJson(
        InsertProductVariantModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
    };
