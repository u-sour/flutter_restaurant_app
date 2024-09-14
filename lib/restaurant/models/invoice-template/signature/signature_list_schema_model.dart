import 'package:json_annotation/json_annotation.dart';
part 'signature_list_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SignatureListSchemaModel {
  final String label;
  final String subLabel;
  final bool visible;
  const SignatureListSchemaModel({
    required this.label,
    required this.subLabel,
    required this.visible,
  });

  factory SignatureListSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$SignatureListSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignatureListSchemaModelToJson(this);
}
