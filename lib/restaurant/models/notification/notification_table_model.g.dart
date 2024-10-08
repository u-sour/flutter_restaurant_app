// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationTableModel _$NotificationTableModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return NotificationTableModel(
    id: json['_id'] as String,
    floorId: json['floorId'] as String,
    name: json['name'] as String,
    numOfGuest: (json['numOfGuest'] as num).toInt(),
    branchId: json['branchId'] as String,
  );
}

Map<String, dynamic> _$NotificationTableModelToJson(
        NotificationTableModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'floorId': instance.floorId,
      'name': instance.name,
      'numOfGuest': instance.numOfGuest,
      'branchId': instance.branchId,
    };
