// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariantListModel _$ProductVariantListModelFromJson(
        Map<String, dynamic> json) =>
    ProductVariantListModel(
      label: json['label'] as String,
      value: json['value'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              ProductVariantItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductVariantListModelToJson(
        ProductVariantListModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
