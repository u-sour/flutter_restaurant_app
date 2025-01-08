// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description_left_right_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DescriptionLeftRightSchemaModel _$DescriptionLeftRightSchemaModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['showOnReceipt'],
  );
  return DescriptionLeftRightSchemaModel(
    id: json['id'] as String,
    type: json['type'] as String,
    groupId: (json['groupId'] as num).toInt(),
    label: json['label'] as String,
    subLabel: json['subLabel'] as String,
    value: json['value'] as String,
    key: json['key'] as String,
    field: json['field'] as String,
    visible: json['visible'] as bool,
    showOnReceipt: json['showOnReceipt'] as bool?,
  );
}

Map<String, dynamic> _$DescriptionLeftRightSchemaModelToJson(
        DescriptionLeftRightSchemaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'groupId': instance.groupId,
      'label': instance.label,
      'subLabel': instance.subLabel,
      'value': instance.value,
      'key': instance.key,
      'field': instance.field,
      'visible': instance.visible,
      if (instance.showOnReceipt case final value?) 'showOnReceipt': value,
    };
