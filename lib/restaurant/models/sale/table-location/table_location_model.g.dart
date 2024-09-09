// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableLocationModel _$TableLocationModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return TableLocationModel(
    id: json['_id'] as String,
    table: json['table'] as String,
    floor: json['floor'] as String,
  );
}

Map<String, dynamic> _$TableLocationModelToJson(TableLocationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'table': instance.table,
      'floor': instance.floor,
    };
