import 'package:json_annotation/json_annotation.dart';
import '../label_style_model.dart';
import '../value_style_model.dart';
part 'header_list_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HeaderListSchemaModel {
  final String id;
  final int index;
  final String type;
  @JsonKey(disallowNullValue: true)
  final String? value;
  final int groupId;
  @JsonKey(disallowNullValue: true)
  final String? label;
  @JsonKey(disallowNullValue: true)
  final String? position;
  @JsonKey(disallowNullValue: true)
  final String? imageId;
  final String field;
  final String? imageUrl;
  @JsonKey(disallowNullValue: true)
  final bool? isVisible;
  @JsonKey(disallowNullValue: true)
  final ValueStyleModel? wrapperStyle;
  final LabelStyleModel? labelStyle;
  final ValueStyleModel valueStyle;

  const HeaderListSchemaModel({
    required this.id,
    required this.index,
    required this.type,
    required this.groupId,
    this.label,
    this.value,
    this.position,
    this.imageId,
    required this.field,
    this.imageUrl,
    this.isVisible,
    this.wrapperStyle,
    this.labelStyle,
    required this.valueStyle,
  });

  factory HeaderListSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$HeaderListSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderListSchemaModelToJson(this);
}
