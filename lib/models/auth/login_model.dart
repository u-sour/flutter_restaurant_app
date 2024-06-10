import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginModel {
  final String username;
  final String password;
  final bool rememberMe;

  const LoginModel({
    required this.username,
    required this.password,
    required this.rememberMe,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
