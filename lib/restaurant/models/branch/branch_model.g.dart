// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return BranchModel(
    id: json['_id'] as String,
    code: json['code'] as String,
    localName: json['localName'] as String,
    localAddress: json['localAddress'] as String,
    telephone: json['telephone'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'localName': instance.localName,
      'localAddress': instance.localAddress,
      'telephone': instance.telephone,
      'status': instance.status,
    };
