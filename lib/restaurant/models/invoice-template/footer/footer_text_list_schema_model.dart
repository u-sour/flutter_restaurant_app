import 'package:json_annotation/json_annotation.dart';
import '../label_style_model.dart';
part 'footer_text_list_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FooterTextListSchemaModel {
  final String id;
  final int index;
  final String type;
  final String value;
  final LabelStyleModel style;

  const FooterTextListSchemaModel({
    required this.id,
    required this.index,
    required this.type,
    required this.value,
    required this.style,
  });

  factory FooterTextListSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$FooterTextListSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$FooterTextListSchemaModelToJson(this);
}
