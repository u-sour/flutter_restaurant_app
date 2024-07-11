import 'package:json_annotation/json_annotation.dart';
part 'sale_config_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleConfigReportModel {
  final String? paperSize;

  const SaleConfigReportModel({
    this.paperSize,
  });

  factory SaleConfigReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleConfigReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleConfigReportModelToJson(this);
}
