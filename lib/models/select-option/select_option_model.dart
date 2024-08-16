import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../utils/model_converter/icon_model_converter.dart';
part 'select_option_model.g.dart';

@JsonSerializable()
class SelectOptionModel {
  @JsonKey(
      disallowNullValue: true,
      fromJson: IconModelConverter.convertIconOptionalForModel,
      toJson: IconModelConverter.convertIconOptionalForModel)
  final IconData? icon;
  final String label;
  final dynamic value;
  final dynamic extra;

  const SelectOptionModel({
    this.icon,
    required this.label,
    required this.value,
    this.extra,
  });

  factory SelectOptionModel.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SelectOptionModelToJson(this);
}
