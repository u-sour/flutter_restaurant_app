import 'package:json_annotation/json_annotation.dart';
part 'description_left_right_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DescriptionLeftRightSchemaModel {
  final String id;
  final String type;
  final int groupId;
  final String label;
  final String subLabel;
  final String value;
  final String key;
  final String field;
  final bool visible;
  @JsonKey(disallowNullValue: true)
  final bool? showOnReceipt;

  const DescriptionLeftRightSchemaModel({
    required this.id,
    required this.type,
    required this.groupId,
    required this.label,
    required this.subLabel,
    required this.value,
    required this.key,
    required this.field,
    required this.visible,
    this.showOnReceipt,
  });

  factory DescriptionLeftRightSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$DescriptionLeftRightSchemaModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$DescriptionLeftRightSchemaModelToJson(this);
}
