// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_text_list_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FooterTextListSchemaModel _$FooterTextListSchemaModelFromJson(
        Map<String, dynamic> json) =>
    FooterTextListSchemaModel(
      id: json['id'] as String,
      index: (json['index'] as num).toInt(),
      type: json['type'] as String,
      value: json['value'] as String,
      style: LabelStyleModel.fromJson(json['style'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FooterTextListSchemaModelToJson(
        FooterTextListSchemaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'type': instance.type,
      'value': instance.value,
      'style': instance.style.toJson(),
    };
