// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestModel _$GuestModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return GuestModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    branchId: json['branchId'] as String,
    createdAt: DateModelConverter.convertDateTimeForModel(
        json['createdAt'] as DateTime),
  );
}

Map<String, dynamic> _$GuestModelToJson(GuestModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'branchId': instance.branchId,
      'createdAt':
          DateModelConverter.convertDateTimeForModel(instance.createdAt),
    };
