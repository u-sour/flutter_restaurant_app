import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'sale_detail_data_detail_report_model.dart';
part 'sale_detail_data_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailDataReportModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final dynamic id;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String employeeName;
  final String itemName;
  final num qty;
  final num price;
  final num amount;
  final num discountAmount;
  final List<SaleDetailDataDetailReportModel> details;
  final String groupLabel;

  SaleDetailDataReportModel({
    required this.id,
    required this.date,
    required this.employeeName,
    required this.itemName,
    required this.qty,
    required this.price,
    required this.amount,
    required this.discountAmount,
    required this.details,
    required this.groupLabel,
  });

  factory SaleDetailDataReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailDataReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDetailDataReportModelToJson(this);
}
