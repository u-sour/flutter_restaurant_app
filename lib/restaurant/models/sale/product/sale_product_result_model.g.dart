// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_product_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleProductResultModel _$SaleProductResultModelFromJson(
        Map<String, dynamic> json) =>
    SaleProductResultModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => SaleProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemCount: (json['itemCount'] as num).toInt(),
    );

Map<String, dynamic> _$SaleProductResultModelToJson(
        SaleProductResultModel instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'itemCount': instance.itemCount,
    };
