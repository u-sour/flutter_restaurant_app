import 'package:flutter_template/restaurant/models/invoice-template/footer/footer_text_schema_model.dart';
import 'package:flutter_template/restaurant/models/invoice-template/qr-code/qr_code_schema_model.dart';
import 'package:flutter_template/restaurant/models/invoice-template/signature/signature_schema_model.dart';
import 'package:flutter_template/restaurant/models/invoice-template/total/total_schema_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'layout_model.dart';
import 'header/header_schema_model.dart';
import 'description/description_schema_model.dart';
import 'table/table_schema_model.dart';
part 'invoice_paper_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoicePaperModel {
  final LayoutModel layout;
  final HeaderSchemaModel headerSchema;
  final DescriptionSchemaModel descriptionSchema;
  final TableSchemaModel tableSchema;
  final TotalSchemaModel totalSchema;
  final SignatureSchemaModel signatureSchema;
  final QrCodeSchemaModel qrCodeSchema;
  final FooterTextSchemaModel footerTextSchema;

  const InvoicePaperModel({
    required this.layout,
    required this.headerSchema,
    required this.descriptionSchema,
    required this.tableSchema,
    required this.totalSchema,
    required this.signatureSchema,
    required this.qrCodeSchema,
    required this.footerTextSchema,
  });

  factory InvoicePaperModel.fromJson(Map<String, dynamic> json) =>
      _$InvoicePaperModelFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicePaperModelToJson(this);
}
