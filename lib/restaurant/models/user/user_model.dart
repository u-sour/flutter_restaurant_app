import 'package:json_annotation/json_annotation.dart';
import '../../utils/model_converter/date_model_converter.dart';
import 'user_email_model.dart';
import 'user_profile_model.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String username;
  final List<UserEmailModel> emails;
  final UserProfileModel profile;

  const UserModel(
      {required this.id,
      required this.username,
      required this.emails,
      required this.profile});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
