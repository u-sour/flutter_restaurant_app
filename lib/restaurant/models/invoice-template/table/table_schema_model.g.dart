// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableSchemaModel _$TableSchemaModelFromJson(Map<String, dynamic> json) =>
    TableSchemaModel(
      borderMode: json['borderMode'] as String,
      showThSubLabel: json['showThSubLabel'] as bool,
      thStyle: ThStyleModel.fromJson(json['thStyle'] as Map<String, dynamic>),
      tdStyle: TdStyleModel.fromJson(json['tdStyle'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>)
          .map((e) => TableListSchemaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TableSchemaModelToJson(TableSchemaModel instance) =>
    <String, dynamic>{
      'borderMode': instance.borderMode,
      'showThSubLabel': instance.showThSubLabel,
      'thStyle': instance.thStyle.toJson(),
      'tdStyle': instance.tdStyle.toJson(),
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
