// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_item_input_catalog_type_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertItemInputCatalogTypeSetModel _$InsertItemInputCatalogTypeSetModelFromJson(
        Map<String, dynamic> json) =>
    InsertItemInputCatalogTypeSetModel(
      invoiceId: json['invoiceId'] as String,
      status: json['status'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      branchId: json['branchId'] as String,
    );

Map<String, dynamic> _$InsertItemInputCatalogTypeSetModelToJson(
        InsertItemInputCatalogTypeSetModel instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'status': instance.status,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'branchId': instance.branchId,
    };
