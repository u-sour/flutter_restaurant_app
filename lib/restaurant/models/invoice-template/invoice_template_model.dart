import 'package:json_annotation/json_annotation.dart';
import 'invoice_paper_model.dart';
part 'invoice_template_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceTemplateModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String branchId;
  final String paperSize;
  final InvoicePaperModel a5;
  final InvoicePaperModel mini;
  final String refNoType;

  const InvoiceTemplateModel({
    required this.id,
    required this.branchId,
    required this.paperSize,
    required this.a5,
    required this.mini,
    required this.refNoType,
  });

  factory InvoiceTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceTemplateModelFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceTemplateModelToJson(this);
}
