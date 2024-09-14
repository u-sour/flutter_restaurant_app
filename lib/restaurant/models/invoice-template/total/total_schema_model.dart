import 'package:json_annotation/json_annotation.dart';
import '../label_style_model.dart';
import 'total_list_schema_model.dart';
part 'total_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TotalSchemaModel {
  final List<String> displayCurrencies;
  final LabelStyleModel labelStyle;
  final List<TotalListSchemaModel> list;

  const TotalSchemaModel({
    required this.displayCurrencies,
    required this.labelStyle,
    required this.list,
  });

  factory TotalSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$TotalSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$TotalSchemaModelToJson(this);
}
