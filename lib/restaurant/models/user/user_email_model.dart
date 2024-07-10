import 'package:json_annotation/json_annotation.dart';
part 'user_email_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEmailModel {
  final String address;
  final bool verified;

  const UserEmailModel({
    required this.address,
    required this.verified,
  });

  factory UserEmailModel.fromJson(Map<String, dynamic> json) =>
      _$UserEmailModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserEmailModelToJson(this);
}
