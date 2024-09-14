import 'package:json_annotation/json_annotation.dart';
part 'wrapper_style_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WrapperStyleModel {
  @JsonKey(name: 'padding-top', disallowNullValue: true)
  final double? paddingTop;
  @JsonKey(name: 'border-top-style', disallowNullValue: true)
  final String? borderTopStyle;

  const WrapperStyleModel({
    required this.paddingTop,
    required this.borderTopStyle,
  });

  factory WrapperStyleModel.fromJson(Map<String, dynamic> json) =>
      _$WrapperStyleModelFromJson(json);
  Map<String, dynamic> toJson() => _$WrapperStyleModelToJson(this);
}
