import 'package:json_annotation/json_annotation.dart';
part 'qr_code_list_schema_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QrCodeListSchemaModel {
  final String id;
  final int index;
  final String imageId;
  final String bankName;
  final String accountName;
  final String accountNumber;
  @JsonKey(disallowNullValue: true)
  final String? imageUrl;
  @JsonKey(disallowNullValue: true)
  final bool? invalidImage;

  const QrCodeListSchemaModel({
    required this.id,
    required this.index,
    required this.imageId,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    this.imageUrl,
    this.invalidImage,
  });

  factory QrCodeListSchemaModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeListSchemaModelFromJson(json);
  Map<String, dynamic> toJson() => _$QrCodeListSchemaModelToJson(this);
}
