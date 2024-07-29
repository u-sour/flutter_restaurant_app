// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_product_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleProductGroupModel _$SaleProductGroupModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleProductGroupModel(
    id: json['_id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$SaleProductGroupModelToJson(
        SaleProductGroupModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
