// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as String,
      qty: (json['qty'] as num).toInt(),
      cost: json['cost'] as num,
      amount: json['amount'] as num,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'qty': instance.qty,
      'cost': instance.cost,
      'amount': instance.amount,
    };
