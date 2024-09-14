import 'package:json_annotation/json_annotation.dart';
import '../label_style_model.dart';
import '../value_style_model.dart';
part 'total_list_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TotalListSchemaModel {
  final String id;
  final int index;
  final int groupId;
  final String key;
  final String label;
  final String field;
  final bool isVisible;
  @JsonKey(disallowNullValue: true)
  final List<String>? invoiceType;
  final LabelStyleModel labelStyle;
  final ValueStyleModel valueStyle;

  const TotalListSchemaModel({
    required this.id,
    required this.index,
    required this.groupId,
    required this.key,
    required this.label,
    required this.field,
    required this.isVisible,
    this.invoiceType,
    required this.labelStyle,
    required this.valueStyle,
  });

  factory TotalListSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$TotalListSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$TotalListSchemaModelToJson(this);
}
