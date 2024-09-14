// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalSchemaModel _$TotalSchemaModelFromJson(Map<String, dynamic> json) =>
    TotalSchemaModel(
      displayCurrencies: (json['displayCurrencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      labelStyle:
          LabelStyleModel.fromJson(json['labelStyle'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>)
          .map((e) => TotalListSchemaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TotalSchemaModelToJson(TotalSchemaModel instance) =>
    <String, dynamic>{
      'displayCurrencies': instance.displayCurrencies,
      'labelStyle': instance.labelStyle.toJson(),
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
