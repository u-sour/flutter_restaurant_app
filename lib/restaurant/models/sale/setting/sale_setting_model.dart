import 'package:json_annotation/json_annotation.dart';
import 'sale_config_invoice_model.dart';
import 'sale_config_model.dart';
import 'sale_config_report_model.dart';
part 'sale_setting_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleSettingModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String branchId;
  final SaleConfigModel sale;
  final SaleConfigInvoiceModel invoice;
  final SaleConfigReportModel? report;

  const SaleSettingModel({
    required this.id,
    required this.branchId,
    required this.sale,
    required this.invoice,
    this.report,
  });

  factory SaleSettingModel.fromJson(Map<String, dynamic> json) =>
      _$SaleSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleSettingModelToJson(this);
}
