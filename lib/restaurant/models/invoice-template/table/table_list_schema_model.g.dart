// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_list_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableListSchemaModel _$TableListSchemaModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['subItemStyle'],
  );
  return TableListSchemaModel(
    id: json['id'] as String,
    position: json['position'] as String,
    groupId: (json['groupId'] as num).toInt(),
    key: json['key'] as String,
    label: json['label'] as String,
    subLabel: json['subLabel'] as String,
    field: json['field'] as String,
    isVisible: json['isVisible'] as bool,
    alignClass: json['alignClass'] as String,
    thStyle: ThStyleModel.fromJson(json['thStyle'] as Map<String, dynamic>),
    tdStyle: TdStyleModel.fromJson(json['tdStyle'] as Map<String, dynamic>),
    subItemStyle: json['subItemStyle'] == null
        ? null
        : ThStyleModel.fromJson(json['subItemStyle'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TableListSchemaModelToJson(
    TableListSchemaModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'position': instance.position,
    'groupId': instance.groupId,
    'key': instance.key,
    'label': instance.label,
    'subLabel': instance.subLabel,
    'field': instance.field,
    'isVisible': instance.isVisible,
    'alignClass': instance.alignClass,
    'thStyle': instance.thStyle.toJson(),
    'tdStyle': instance.tdStyle.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subItemStyle', instance.subItemStyle?.toJson());
  return val;
}
