import 'package:json_annotation/json_annotation.dart';
part 'label_style_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LabelStyleModel {
  @JsonKey(name: 'font-size', disallowNullValue: true)
  final double? fontSize;
  @JsonKey(name: 'font-weight', disallowNullValue: true)
  final String? fontWeight;
  @JsonKey(name: 'line-height', disallowNullValue: true)
  final String? lineHeight;
  @JsonKey(name: 'justify-content', disallowNullValue: true)
  final String? justifyContent;
  @JsonKey(name: 'text-align', disallowNullValue: true)
  final String? textAlign;
  @JsonKey(name: 'margin-right', disallowNullValue: true)
  final double? marginRight;
  @JsonKey(name: 'padding-top', disallowNullValue: true)
  final double? paddingTop;
  @JsonKey(name: 'padding-right', disallowNullValue: true)
  final double? paddingRight;
  @JsonKey(name: 'padding-bottom', disallowNullValue: true)
  final double? paddingBottom;

  const LabelStyleModel({
    this.fontSize,
    this.fontWeight,
    this.lineHeight,
    this.justifyContent,
    this.textAlign,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.marginRight,
  });

  factory LabelStyleModel.fromJson(Map<String, dynamic> json) =>
      _$LabelStyleModelFromJson(json);
  Map<String, dynamic> toJson() => _$LabelStyleModelToJson(this);
}
