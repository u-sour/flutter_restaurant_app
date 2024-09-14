// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_list_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderListSchemaModel _$HeaderListSchemaModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      'value',
      'label',
      'position',
      'imageId',
      'isVisible',
      'wrapperStyle'
    ],
  );
  return HeaderListSchemaModel(
    id: json['id'] as String,
    index: (json['index'] as num).toInt(),
    type: json['type'] as String,
    groupId: (json['groupId'] as num).toInt(),
    label: json['label'] as String?,
    value: json['value'] as String?,
    position: json['position'] as String?,
    imageId: json['imageId'] as String?,
    field: json['field'] as String,
    imageUrl: json['imageUrl'] as String?,
    isVisible: json['isVisible'] as bool?,
    wrapperStyle: json['wrapperStyle'] == null
        ? null
        : ValueStyleModel.fromJson(
            json['wrapperStyle'] as Map<String, dynamic>),
    labelStyle: json['labelStyle'] == null
        ? null
        : LabelStyleModel.fromJson(json['labelStyle'] as Map<String, dynamic>),
    valueStyle:
        ValueStyleModel.fromJson(json['valueStyle'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HeaderListSchemaModelToJson(
    HeaderListSchemaModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'index': instance.index,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  val['groupId'] = instance.groupId;
  writeNotNull('label', instance.label);
  writeNotNull('position', instance.position);
  writeNotNull('imageId', instance.imageId);
  val['field'] = instance.field;
  val['imageUrl'] = instance.imageUrl;
  writeNotNull('isVisible', instance.isVisible);
  writeNotNull('wrapperStyle', instance.wrapperStyle?.toJson());
  val['labelStyle'] = instance.labelStyle?.toJson();
  val['valueStyle'] = instance.valueStyle.toJson();
  return val;
}
