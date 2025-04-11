// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_data_detail_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailDataDetailReportModel _$SaleDetailDataDetailReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleDetailDataDetailReportModel(
      groupLabel: json['groupLabel'] as String?,
      no: (json['no'] as num?)?.toInt(),
      invoiceId: json['invoiceId'] as String,
      refNo: json['refNo'] as String,
      date:
          DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
      employeeName: json['employeeName'] as String,
      tableName: json['tableName'] as String,
      floorName: json['floorName'] as String,
      departmentName: json['departmentName'] as String,
      itemName: json['itemName'] as String,
      variantName: json['variantName'] as String?,
      itemType: json['itemType'] as String,
      qty: json['qty'] as num,
      price: json['price'] as num,
      discount: json['discount'] as num,
      amount: json['amount'] as num,
      discountAmount: json['discountAmount'] as num,
    );

Map<String, dynamic> _$SaleDetailDataDetailReportModelToJson(
        SaleDetailDataDetailReportModel instance) =>
    <String, dynamic>{
      'groupLabel': instance.groupLabel,
      'no': instance.no,
      'invoiceId': instance.invoiceId,
      'refNo': instance.refNo,
      'date': DateModelConverter.convertDateTimeForModel(instance.date),
      'employeeName': instance.employeeName,
      'tableName': instance.tableName,
      'floorName': instance.floorName,
      'departmentName': instance.departmentName,
      'itemName': instance.itemName,
      'variantName': instance.variantName,
      'itemType': instance.itemType,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
      'discountAmount': instance.discountAmount,
    };
