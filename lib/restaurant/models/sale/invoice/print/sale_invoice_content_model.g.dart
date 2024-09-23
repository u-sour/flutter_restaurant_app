// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceContentModel _$SaleInvoiceContentModelFromJson(
        Map<String, dynamic> json) =>
    SaleInvoiceContentModel(
      saleDoc: SaleInvoiceForPrintModel.fromJson(
          json['saleDoc'] as Map<String, dynamic>),
      orderList: (json['orderList'] as List<dynamic>)
          .map((e) =>
              SaleDetailForPrintModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      exchangeDoc:
          ExchangeModel.fromJson(json['exchangeDoc'] as Map<String, dynamic>),
      receiptDoc: json['receiptDoc'] == null
          ? null
          : SaleReceiptForPrintModel.fromJson(
              json['receiptDoc'] as Map<String, dynamic>),
      subTotal: json['subTotal'] as num,
      totalAmountExchange: ConvertToMultiExchangeModel.fromJson(
          json['totalAmountExchange'] as Map<String, dynamic>),
      feeAmount: json['feeAmount'] as num,
      prevReceiveAmount: json['prevReceiveAmount'] as num,
      receiveAmountExchange: json['receiveAmountExchange'] == null
          ? null
          : ConvertToMultiExchangeModel.fromJson(
              json['receiveAmountExchange'] as Map<String, dynamic>),
      returnAmountExchange: json['returnAmountExchange'] == null
          ? null
          : ConvertToMultiExchangeModel.fromJson(
              json['returnAmountExchange'] as Map<String, dynamic>),
      returnAmountType: json['returnAmountType'] as String?,
    );

Map<String, dynamic> _$SaleInvoiceContentModelToJson(
        SaleInvoiceContentModel instance) =>
    <String, dynamic>{
      'saleDoc': instance.saleDoc.toJson(),
      'orderList': instance.orderList.map((e) => e.toJson()).toList(),
      'exchangeDoc': instance.exchangeDoc.toJson(),
      'receiptDoc': instance.receiptDoc?.toJson(),
      'subTotal': instance.subTotal,
      'totalAmountExchange': instance.totalAmountExchange.toJson(),
      'feeAmount': instance.feeAmount,
      'prevReceiveAmount': instance.prevReceiveAmount,
      'receiveAmountExchange': instance.receiveAmountExchange?.toJson(),
      'returnAmountExchange': instance.returnAmountExchange?.toJson(),
      'returnAmountType': instance.returnAmountType,
    };
