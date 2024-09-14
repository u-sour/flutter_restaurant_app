import 'package:flutter_template/restaurant/models/invoice-template/wrapper_style_model.dart';
import 'package:json_annotation/json_annotation.dart';
import '../label_style_model.dart';
import 'signature_list_schema_model.dart';
part 'signature_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SignatureSchemaModel {
  final List<SignatureListSchemaModel> list;
  final WrapperStyleModel wrapperStyle;
  final LabelStyleModel labelStyle;
  final LabelStyleModel subLabelStyle;
  const SignatureSchemaModel({
    required this.list,
    required this.wrapperStyle,
    required this.labelStyle,
    required this.subLabelStyle,
  });

  factory SignatureSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$SignatureSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignatureSchemaModelToJson(this);
}
