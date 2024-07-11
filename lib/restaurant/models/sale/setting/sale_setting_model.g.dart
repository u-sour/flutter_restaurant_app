// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleSettingModel _$SaleSettingModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleSettingModel(
    id: json['_id'] as String,
    branchId: json['branchId'] as String,
    sale: SaleConfigModel.fromJson(json['sale'] as Map<String, dynamic>),
    invoice: SaleConfigInvoiceModel.fromJson(
        json['invoice'] as Map<String, dynamic>),
    report: json['report'] == null
        ? null
        : SaleConfigReportModel.fromJson(
            json['report'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SaleSettingModelToJson(SaleSettingModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'branchId': instance.branchId,
      'sale': instance.sale.toJson(),
      'invoice': instance.invoice.toJson(),
      'report': instance.report?.toJson(),
    };
