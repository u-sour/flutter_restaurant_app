// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_paper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicePaperModel _$InvoicePaperModelFromJson(Map<String, dynamic> json) =>
    InvoicePaperModel(
      layout: LayoutModel.fromJson(json['layout'] as Map<String, dynamic>),
      headerSchema: HeaderSchemaModel.fromJson(
          json['headerSchema'] as Map<String, dynamic>),
      descriptionSchema: DescriptionSchemaModel.fromJson(
          json['descriptionSchema'] as Map<String, dynamic>),
      tableSchema: TableSchemaModel.fromJson(
          json['tableSchema'] as Map<String, dynamic>),
      totalSchema: TotalSchemaModel.fromJson(
          json['totalSchema'] as Map<String, dynamic>),
      signatureSchema: SignatureSchemaModel.fromJson(
          json['signatureSchema'] as Map<String, dynamic>),
      qrCodeSchema: QrCodeSchemaModel.fromJson(
          json['qrCodeSchema'] as Map<String, dynamic>),
      footerTextSchema: FooterTextSchemaModel.fromJson(
          json['footerTextSchema'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoicePaperModelToJson(InvoicePaperModel instance) =>
    <String, dynamic>{
      'layout': instance.layout.toJson(),
      'headerSchema': instance.headerSchema.toJson(),
      'descriptionSchema': instance.descriptionSchema.toJson(),
      'tableSchema': instance.tableSchema.toJson(),
      'totalSchema': instance.totalSchema.toJson(),
      'signatureSchema': instance.signatureSchema.toJson(),
      'qrCodeSchema': instance.qrCodeSchema.toJson(),
      'footerTextSchema': instance.footerTextSchema.toJson(),
    };
