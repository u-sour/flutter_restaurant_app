import 'package:json_annotation/json_annotation.dart';
import 'header_list_schema_model.dart';
part 'header_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HeaderSchemaModel {
  final List<HeaderListSchemaModel> list;

  const HeaderSchemaModel({required this.list});

  factory HeaderSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$HeaderSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderSchemaModelToJson(this);
}
