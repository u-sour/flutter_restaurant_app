import 'package:json_annotation/json_annotation.dart';
part 'layout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LayoutModel {
  @JsonKey(name: 'margin-top', disallowNullValue: true)
  final double marginTop;
  @JsonKey(name: 'margin-bottom', disallowNullValue: true)
  final double marginBottom;
  @JsonKey(name: 'margin-left', disallowNullValue: true)
  final double marginLeft;
  @JsonKey(name: 'margin-right', disallowNullValue: true)
  final double marginRight;

  const LayoutModel({
    required this.marginTop,
    required this.marginBottom,
    required this.marginLeft,
    required this.marginRight,
  });

  factory LayoutModel.fromJson(Map<String, dynamic> json) =>
      _$LayoutModelFromJson(json);
  Map<String, dynamic> toJson() => _$LayoutModelToJson(this);
}
