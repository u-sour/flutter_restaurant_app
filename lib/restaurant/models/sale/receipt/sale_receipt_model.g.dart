// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleReceiptModel _$SaleReceiptModelFromJson(Map<String, dynamic> json) =>
    SaleReceiptModel(
      exchangeDoc:
          ExchangeModel.fromJson(json['exchangeDoc'] as Map<String, dynamic>),
      orderDoc: SaleModel.fromJson(json['orderDoc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleReceiptModelToJson(SaleReceiptModel instance) =>
    <String, dynamic>{
      'exchangeDoc': instance.exchangeDoc.toJson(),
      'orderDoc': instance.orderDoc.toJson(),
    };
