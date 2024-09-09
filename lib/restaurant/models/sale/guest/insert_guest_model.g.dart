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

Map<String, dynamic> _$InsertGuestModelToJson(InsertGuestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['name'] = instance.name;
  writeNotNull('telephone', instance.telephone);
  writeNotNull('address', instance.address);
  val['branchId'] = instance.branchId;
  return val;
}
