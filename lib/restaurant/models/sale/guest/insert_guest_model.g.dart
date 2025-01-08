// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_guest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertGuestModel _$InsertGuestModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return InsertGuestModel(
    id: json['_id'] as String?,
    name: json['name'] as String,
    telephone: json['telephone'] as String?,
    address: json['address'] as String?,
    branchId: json['branchId'] as String,
  );
}

Map<String, dynamic> _$InsertGuestModelToJson(InsertGuestModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) '_id': value,
      'name': instance.name,
      if (instance.telephone case final value?) 'telephone': value,
      if (instance.address case final value?) 'address': value,
      'branchId': instance.branchId,
    };
