// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      fullName: json['fullName'] as String,
      branchPermissions: (json['branchPermissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      roleGroup: json['roleGroup'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      depIds:
          (json['depIds'] as List<dynamic>).map((e) => e as String).toList(),
      profilePic: json['profilePic'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'branchPermissions': instance.branchPermissions,
      'roleGroup': instance.roleGroup,
      'roles': instance.roles,
      'depIds': instance.depIds,
      'profilePic': instance.profilePic,
      'status': instance.status,
    };
