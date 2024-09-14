import 'package:json_annotation/json_annotation.dart';
import 'footer_text_list_schema_model.dart';
part 'footer_text_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FooterTextSchemaModel {
  final List<FooterTextListSchemaModel> list;

  const FooterTextSchemaModel({required this.list});

  factory FooterTextSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$FooterTextSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$FooterTextSchemaModelToJson(this);
}
