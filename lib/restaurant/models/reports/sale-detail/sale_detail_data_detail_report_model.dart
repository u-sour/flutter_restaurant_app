import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
part 'sale_detail_data_detail_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetailDataDetailReportModel {
  final String? groupLabel;
  int? no;
  final String invoiceId;
  final String refNo;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String employeeName;
  final String tableName;
  final String floorName;
  final String departmentName;
  final String itemName;
  final String? variantName;
  final String itemType;
  final num qty;
  final num price;
  final num discount;
  final num amount;
  final num discountAmount;

  SaleDetailDataDetailReportModel({
    this.groupLabel,
    this.no,
    required this.invoiceId,
    required this.refNo,
    required this.date,
    required this.employeeName,
    required this.tableName,
    required this.floorName,
    required this.departmentName,
    required this.itemName,
    this.variantName,
    required this.itemType,
    required this.qty,
    required this.price,
    required this.discount,
    required this.amount,
    required this.discountAmount,
  });

  factory SaleDetailDataDetailReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailDataDetailReportModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SaleDetailDataDetailReportModelToJson(this);
}
