import 'package:json_annotation/json_annotation.dart';
part 'setting_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingModel {
  final String ipAddress;
  SettingModel({required this.ipAddress});

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}
