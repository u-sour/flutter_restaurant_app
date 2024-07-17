// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceModel _$SaleInvoiceModelFromJson(Map<String, dynamic> json) =>
    SaleInvoiceModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => SaleInvoiceDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecords: (json['totalRecords'] as num).toInt(),
    );

Map<String, dynamic> _$SaleInvoiceModelToJson(SaleInvoiceModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'totalRecords': instance.totalRecords,
    };
