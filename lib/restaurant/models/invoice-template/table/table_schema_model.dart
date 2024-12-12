import 'package:json_annotation/json_annotation.dart';
import 'table_list_schema_model.dart';
import 'td_style_model.dart';
import 'th_style_model.dart';
part 'table_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TableSchemaModel {
  final String borderMode;
  final bool showThSubLabel;
  final ThStyleModel thStyle;
  final TdStyleModel tdStyle;
  final List<TableListSchemaModel> list;

  const TableSchemaModel({
    required this.borderMode,
    required this.showThSubLabel,
    required this.thStyle,
    required this.tdStyle,
    required this.list,
  });

  factory TableSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$TableSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableSchemaModelToJson(this);
}
