import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'sale_data_detail_report_model.dart';
part 'sale_data_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDataReportModel {
  @JsonKey(name: '_id')
  final dynamic id;
  final String groupLabel;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String employeeName;
  final List<SaleDataDetailReportModel> details;
  final num subTotal;
  final num discountValue;
  final num total;
  final num totalReceived;

  const SaleDataReportModel({
    required this.id,
    required this.groupLabel,
    required this.date,
    required this.employeeName,
    required this.details,
    required this.subTotal,
    required this.discountValue,
    required this.total,
    required this.totalReceived,
  });

  factory SaleDataReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDataReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDataReportModelToJson(this);
}
