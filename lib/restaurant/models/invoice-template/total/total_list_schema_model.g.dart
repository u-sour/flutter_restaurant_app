// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_list_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalListSchemaModel _$TotalListSchemaModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['invoiceType'],
  );
  return TotalListSchemaModel(
    id: json['id'] as String,
    index: (json['index'] as num).toInt(),
    groupId: (json['groupId'] as num).toInt(),
    key: json['key'] as String,
    label: json['label'] as String,
    field: json['field'] as String,
    isVisible: json['isVisible'] as bool,
    invoiceType: (json['invoiceType'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    labelStyle:
        LabelStyleModel.fromJson(json['labelStyle'] as Map<String, dynamic>),
    valueStyle:
        ValueStyleModel.fromJson(json['valueStyle'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TotalListSchemaModelToJson(
    TotalListSchemaModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'index': instance.index,
    'groupId': instance.groupId,
    'key': instance.key,
    'label': instance.label,
    'field': instance.field,
    'isVisible': instance.isVisible,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('invoiceType', instance.invoiceType);
  val['labelStyle'] = instance.labelStyle.toJson();
  val['valueStyle'] = instance.valueStyle.toJson();
  return val;
}