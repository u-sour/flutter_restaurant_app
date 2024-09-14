import 'package:json_annotation/json_annotation.dart';
part 'td_style_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TdStyleModel {
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
  @JsonKey(name: 'font-weight', disallowNullValue: true)
  final String? fontWeight;

  const TdStyleModel({
    this.fontSize,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
    this.fontWeight,
  });

  factory TdStyleModel.fromJson(Map<String, dynamic> json) =>
      _$TdStyleModelFromJson(json);
  Map<String, dynamic> toJson() => _$TdStyleModelToJson(this);
}
