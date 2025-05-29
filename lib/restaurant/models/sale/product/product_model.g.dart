// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as String,
      variantId: json['variantId'] as String?,
      qty: (json['qty'] as num).toInt(),
      cost: json['cost'] as num,
      amount: json['amount'] as num,
      discount: json['discount'] as num?,
      discountPrice: json['discountPrice'] as num?,
      draft: json['draft'] as bool?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'variantId': instance.variantId,
      'qty': instance.qty,
      'cost': instance.cost,
      'amount': instance.amount,
      'discount': instance.discount,
      'discountPrice': instance.discountPrice,
      'draft': instance.draft,
    };
