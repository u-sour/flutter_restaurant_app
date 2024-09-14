import 'package:json_annotation/json_annotation.dart';
part 'th_style_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ThStyleModel {
  @JsonKey(name: 'font-size', disallowNullValue: true)
  final double? fontSize;
  @JsonKey(name: 'padding-top', disallowNullValue: true)
  final double? paddingTop;
  @JsonKey(name: 'padding-bottom', disallowNullValue: true)
  final double? paddingBottom;
  @JsonKey(name: 'padding-left', disallowNullValue: true)
  final double? paddingLeft;
  @JsonKey(name: 'padding-right', disallowNullValue: true)
  final double? paddingRight;
  @JsonKey(name: 'line-height', disallowNullValue: true)
  final String? lineHeight;
  @JsonKey(disallowNullValue: true)
  final double? width;
  const ThStyleModel({
    this.fontSize,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
    this.lineHeight,
    this.width,
  });

  factory ThStyleModel.fromJson(Map<String, dynamic> json) =>
      _$ThStyleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ThStyleModelToJson(this);
}
