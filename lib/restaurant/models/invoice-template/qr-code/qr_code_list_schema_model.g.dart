// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_list_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeListSchemaModel _$QrCodeListSchemaModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['imageUrl', 'invalidImage'],
  );
  return QrCodeListSchemaModel(
    id: json['id'] as String,
    index: (json['index'] as num).toInt(),
    imageId: json['imageId'] as String,
    bankName: json['bankName'] as String,
    accountName: json['accountName'] as String,
    accountNumber: json['accountNumber'] as String,
    imageUrl: json['imageUrl'] as String?,
    invalidImage: json['invalidImage'] as bool?,
  );
}

Map<String, dynamic> _$QrCodeListSchemaModelToJson(
        QrCodeListSchemaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'imageId': instance.imageId,
      'bankName': instance.bankName,
      'accountName': instance.accountName,
      'accountNumber': instance.accountNumber,
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.invalidImage case final value?) 'invalidImage': value,
    };
