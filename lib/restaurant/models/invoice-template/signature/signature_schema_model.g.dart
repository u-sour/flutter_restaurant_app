// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureSchemaModel _$SignatureSchemaModelFromJson(
        Map<String, dynamic> json) =>
    SignatureSchemaModel(
      list: (json['list'] as List<dynamic>)
          .map((e) =>
              SignatureListSchemaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      wrapperStyle: WrapperStyleModel.fromJson(
          json['wrapperStyle'] as Map<String, dynamic>),
      labelStyle:
          LabelStyleModel.fromJson(json['labelStyle'] as Map<String, dynamic>),
      subLabelStyle: LabelStyleModel.fromJson(
          json['subLabelStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignatureSchemaModelToJson(
        SignatureSchemaModel instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
      'wrapperStyle': instance.wrapperStyle.toJson(),
      'labelStyle': instance.labelStyle.toJson(),
      'subLabelStyle': instance.subLabelStyle.toJson(),
    };
