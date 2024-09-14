import 'package:flutter_template/restaurant/models/invoice-template/container_style_model.dart';
import 'package:json_annotation/json_annotation.dart';
import '../label_style_model.dart';
import '../value_style_model.dart';
import 'qr_code_list_schema_model.dart';
part 'qr_code_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QrCodeSchemaModel {
  final List<QrCodeListSchemaModel> list;
  final ContainerStyleModel containerStyle;
  final ValueStyleModel imagePanelStyle;
  final LabelStyleModel bankNameStyle;
  final LabelStyleModel accountNameStyle;
  final LabelStyleModel accountNumberStyle;

  const QrCodeSchemaModel({
    required this.list,
    required this.containerStyle,
    required this.imagePanelStyle,
    required this.bankNameStyle,
    required this.accountNameStyle,
    required this.accountNumberStyle,
  });

  factory QrCodeSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$QrCodeSchemaModelToJson(this);
}
