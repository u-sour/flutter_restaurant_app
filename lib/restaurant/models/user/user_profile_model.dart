import 'package:json_annotation/json_annotation.dart';
part 'user_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserProfileModel {
  final String fullName;
  final List<String> branchPermissions;
  final String roleGroup;
  final List<String> roles;
  final List<String> depIds;
  final String profilePic;
  final String status;

  const UserProfileModel({
    required this.fullName,
    required this.branchPermissions,
    required this.roleGroup,
    required this.roles,
    required this.depIds,
    required this.profilePic,
    required this.status,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
