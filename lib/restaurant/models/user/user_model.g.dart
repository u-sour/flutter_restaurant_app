// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return UserModel(
    id: json['_id'] as String,
    username: json['username'] as String,
    emails: (json['emails'] as List<dynamic>)
        .map((e) => UserEmailModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    profile: UserProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'emails': instance.emails.map((e) => e.toJson()).toList(),
      'profile': instance.profile.toJson(),
    };
