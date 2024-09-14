import 'package:json_annotation/json_annotation.dart';
part 'value_style_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ValueStyleModel {
  @JsonKey(name: 'font-size', disallowNullValue: true)
  final double? fontSize;
  @JsonKey(name: 'font-weight', disallowNullValue: true)
  final String? fontWeight;
  @JsonKey(name: 'margin-top', disallowNullValue: true)
  final double? marginTop;
  @JsonKey(name: 'margin-bottom', disallowNullValue: true)
  final double? marginBottom;
  @JsonKey(disallowNullValue: true)
  final double? width;
  @JsonKey(name: 'border-radius', disallowNullValue: true)
  final String? borderRadius;
  const ValueStyleModel(
      {this.fontSize,
      this.fontWeight,
      this.marginTop,
      this.marginBottom,
      this.width,
      this.borderRadius});

  factory ValueStyleModel.fromJson(Map<String, dynamic> json) =>
      _$ValueStyleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ValueStyleModelToJson(this);
}
