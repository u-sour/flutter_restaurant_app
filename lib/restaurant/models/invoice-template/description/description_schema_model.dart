import 'package:json_annotation/json_annotation.dart';
import '../label_style_model.dart';
import '../value_style_model.dart';
import 'description_left_right_schema_model.dart';
part 'description_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DescriptionSchemaModel {
  final bool showSubLabel;
  final List<DescriptionLeftRightSchemaModel> left;
  final List<DescriptionLeftRightSchemaModel> right;
  final LabelStyleModel labelStyle;
  final LabelStyleModel subLabelStyle;
  final ValueStyleModel valueStyle;
  const DescriptionSchemaModel({
    required this.showSubLabel,
    required this.left,
    required this.right,
    required this.labelStyle,
    required this.subLabelStyle,
    required this.valueStyle,
  });

  factory DescriptionSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$DescriptionSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$DescriptionSchemaModelToJson(this);
}
