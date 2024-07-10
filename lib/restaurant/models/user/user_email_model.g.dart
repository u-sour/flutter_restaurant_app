// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEmailModel _$UserEmailModelFromJson(Map<String, dynamic> json) =>
    UserEmailModel(
      address: json['address'] as String,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$UserEmailModelToJson(UserEmailModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'verified': instance.verified,
    };
