// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_receipt_total_doc_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleReceiptTotalDocReportModel _$SaleReceiptTotalDocReportModelFromJson(
        Map<String, dynamic> json) =>
    SaleReceiptTotalDocReportModel(
      openAmount: json['openAmount'] as num,
      openAmountDoc: ReportExchangeModel.fromJson(
          json['openAmountDoc'] as Map<String, dynamic>),
      receiveAmount: json['receiveAmount'] as num,
      receiveAmountDoc: ReportExchangeModel.fromJson(
          json['receiveAmountDoc'] as Map<String, dynamic>),
      feeAmount: json['feeAmount'] as num,
      feeAmountDoc: ReportExchangeModel.fromJson(
          json['feeAmountDoc'] as Map<String, dynamic>),
      remainingAmount: json['remainingAmount'] as num,
      remainingAmountDoc: ReportExchangeModel.fromJson(
          json['remainingAmountDoc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleReceiptTotalDocReportModelToJson(
        SaleReceiptTotalDocReportModel instance) =>
    <String, dynamic>{
      'openAmount': instance.openAmount,
      'openAmountDoc': instance.openAmountDoc,
      'receiveAmount': instance.receiveAmount,
      'receiveAmountDoc': instance.receiveAmountDoc,
      'feeAmount': instance.feeAmount,
      'feeAmountDoc': instance.feeAmountDoc,
      'remainingAmount': instance.remainingAmount,
      'remainingAmountDoc': instance.remainingAmountDoc,
    };
