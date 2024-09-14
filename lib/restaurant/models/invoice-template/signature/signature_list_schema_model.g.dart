// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_list_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureListSchemaModel _$SignatureListSchemaModelFromJson(
        Map<String, dynamic> json) =>
    SignatureListSchemaModel(
      label: json['label'] as String,
      subLabel: json['subLabel'] as String,
      visible: json['visible'] as bool,
    );

Map<String, dynamic> _$SignatureListSchemaModelToJson(
        SignatureListSchemaModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'subLabel': instance.subLabel,
      'visible': instance.visible,
    };
