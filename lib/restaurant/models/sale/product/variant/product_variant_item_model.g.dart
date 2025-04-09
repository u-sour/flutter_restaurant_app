// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariantItemModel _$ProductVariantItemModelFromJson(
        Map<String, dynamic> json) =>
    ProductVariantItemModel(
      name: json['name'] as String,
      price: json['price'] as num,
      qty: json['qty'] as num,
      discount: json['discount'] as num,
      discountPrice: json['discountPrice'] as num,
      productId: json['productId'] as String,
      variantId: json['variantId'] as String,
    );

Map<String, dynamic> _$ProductVariantItemModelToJson(
        ProductVariantItemModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
      'discount': instance.discount,
      'discountPrice': instance.discountPrice,
      'productId': instance.productId,
      'variantId': instance.variantId,
    };
