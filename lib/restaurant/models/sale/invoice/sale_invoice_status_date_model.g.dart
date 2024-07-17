// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_status_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceStatusDateModel _$SaleInvoiceStatusDateModelFromJson(
        Map<String, dynamic> json) =>
    SaleInvoiceStatusDateModel(
      open:
          DateModelConverter.convertDateTimeForModel(json['open'] as DateTime),
    );

Map<String, dynamic> _$SaleInvoiceStatusDateModelToJson(
        SaleInvoiceStatusDateModel instance) =>
    <String, dynamic>{
      'open': DateModelConverter.convertDateTimeForModel(instance.open),
    };
