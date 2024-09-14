import 'package:json_annotation/json_annotation.dart';
import 'td_style_model.dart';
import 'th_style_model.dart';
part 'table_list_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TableListSchemaModel {
  final String id;
  final String position;
  final int groupId;
  final String key;
  final String label;
  final String subLabel;
  final String field;
  final bool isVisible;
  final String alignClass;
  final ThStyleModel thStyle;
  final TdStyleModel tdStyle;
  @JsonKey(disallowNullValue: true)
  final ThStyleModel? subItemStyle;

  const TableListSchemaModel({
    required this.id,
    required this.position,
    required this.groupId,
    required this.key,
    required this.label,
    required this.subLabel,
    required this.field,
    required this.isVisible,
    required this.alignClass,
    required this.thStyle,
    required this.tdStyle,
    this.subItemStyle,
  });

  factory TableListSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$TableListSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableListSchemaModelToJson(this);
}
