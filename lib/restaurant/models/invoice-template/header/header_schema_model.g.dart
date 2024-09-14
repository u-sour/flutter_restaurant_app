// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderSchemaModel _$HeaderSchemaModelFromJson(Map<String, dynamic> json) =>
    HeaderSchemaModel(
      list: (json['list'] as List<dynamic>)
          .map((e) => HeaderListSchemaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HeaderSchemaModelToJson(HeaderSchemaModel instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
