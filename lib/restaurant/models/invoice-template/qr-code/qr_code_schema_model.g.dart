// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeSchemaModel _$QrCodeSchemaModelFromJson(Map<String, dynamic> json) =>
    QrCodeSchemaModel(
      list: (json['list'] as List<dynamic>)
          .map((e) => QrCodeListSchemaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      containerStyle: ContainerStyleModel.fromJson(
          json['containerStyle'] as Map<String, dynamic>),
      imagePanelStyle: ValueStyleModel.fromJson(
          json['imagePanelStyle'] as Map<String, dynamic>),
      bankNameStyle: LabelStyleModel.fromJson(
          json['bankNameStyle'] as Map<String, dynamic>),
      accountNameStyle: LabelStyleModel.fromJson(
          json['accountNameStyle'] as Map<String, dynamic>),
      accountNumberStyle: LabelStyleModel.fromJson(
          json['accountNumberStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QrCodeSchemaModelToJson(QrCodeSchemaModel instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
      'containerStyle': instance.containerStyle.toJson(),
      'imagePanelStyle': instance.imagePanelStyle.toJson(),
      'bankNameStyle': instance.bankNameStyle.toJson(),
      'accountNameStyle': instance.accountNameStyle.toJson(),
      'accountNumberStyle': instance.accountNumberStyle.toJson(),
    };
