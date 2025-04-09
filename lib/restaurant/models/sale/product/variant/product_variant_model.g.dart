// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) =>
    ProductVariantModel(
      optionName: json['optionName'] as String,
      variantList: (json['variantList'] as List<dynamic>)
          .map((e) =>
              ProductVariantListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductVariantModelToJson(
        ProductVariantModel instance) =>
    <String, dynamic>{
      'optionName': instance.optionName,
      'variantList': instance.variantList.map((e) => e.toJson()).toList(),
    };
