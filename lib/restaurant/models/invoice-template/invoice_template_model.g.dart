// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceTemplateModel _$InvoiceTemplateModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return InvoiceTemplateModel(
    id: json['_id'] as String,
    branchId: json['branchId'] as String,
    paperSize: json['paperSize'] as String,
    a5: InvoicePaperModel.fromJson(json['a5'] as Map<String, dynamic>),
    mini: InvoicePaperModel.fromJson(json['mini'] as Map<String, dynamic>),
    refNoType: json['refNoType'] as String,
  );
}

Map<String, dynamic> _$InvoiceTemplateModelToJson(
        InvoiceTemplateModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'branchId': instance.branchId,
      'paperSize': instance.paperSize,
      'a5': instance.a5.toJson(),
      'mini': instance.mini.toJson(),
      'refNoType': instance.refNoType,
    };
