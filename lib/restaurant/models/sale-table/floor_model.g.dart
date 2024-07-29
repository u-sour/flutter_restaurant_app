// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return FloorModel(
    id: json['_id'] as String,
    branchId: json['branchId'] as String,
    depId: json['depId'] as String,
    name: json['name'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$FloorModelToJson(FloorModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'branchId': instance.branchId,
      'depId': instance.depId,
      'name': instance.name,
      'status': instance.status,
    };
