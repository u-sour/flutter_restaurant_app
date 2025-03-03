// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_to_kitchen_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceToKitchenContentModel _$SaleInvoiceToKitchenContentModelFromJson(
        Map<String, dynamic> json) =>
    SaleInvoiceToKitchenContentModel(
      templateMargin: json['templateMargin'] as String,
      orderNum: json['orderNum'] as String,
      tableId: json['tableId'] as String,
      tableName: json['tableName'] as String,
      orderList: (json['orderList'] as List<dynamic>)
          .map((e) => SaleDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderListByStation: (json['orderListByStation'] as List<dynamic>?)
          ?.map((e) =>
              OrderListByStationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaleInvoiceToKitchenContentModelToJson(
        SaleInvoiceToKitchenContentModel instance) =>
    <String, dynamic>{
      'templateMargin': instance.templateMargin,
      'orderNum': instance.orderNum,
      'tableId': instance.tableId,
      'tableName': instance.tableName,
      'orderList': instance.orderList.map((e) => e.toJson()).toList(),
      'orderListByStation':
          instance.orderListByStation?.map((e) => e.toJson()).toList(),
    };
