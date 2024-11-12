import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../utils/model_converter/icon_model_converter.dart';
part 'option_model.g.dart';

@JsonSerializable()
class OptionModel {
  @JsonKey(
      disallowNullValue: true,
      fromJson: IconModelConverter.convertIconOptionalForModel,
      toJson: IconModelConverter.convertIconOptionalForModel)
  final IconData? icon;
  final String label;
  dynamic value;
  @JsonKey(disallowNullValue: true)
  dynamic extra;

  OptionModel({
    this.icon,
    required this.label,
    required this.value,
    this.extra,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) =>
      _$OptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$OptionModelToJson(this);
}
