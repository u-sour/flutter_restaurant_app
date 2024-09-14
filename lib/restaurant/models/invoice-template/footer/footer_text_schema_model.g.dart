// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_text_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FooterTextSchemaModel _$FooterTextSchemaModelFromJson(
        Map<String, dynamic> json) =>
    FooterTextSchemaModel(
      list: (json['list'] as List<dynamic>)
          .map((e) =>
              FooterTextListSchemaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FooterTextSchemaModelToJson(
        FooterTextSchemaModel instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
