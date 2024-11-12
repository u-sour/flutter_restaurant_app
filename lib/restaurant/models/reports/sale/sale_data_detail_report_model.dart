import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
part 'sale_data_detail_report_model.g.dart';

@JsonSerializable()
class SaleDataDetailReportModel {
  final String? groupLabel;
  int? no;
  final String orderNum;
  final String refNo;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeOptionalForModel,
      toJson: DateModelConverter.convertDateTimeOptionalForModel)
  final DateTime? outDate;
  final String type;
  final String status;
  final num discountRate;
  final num discountValue;
  final num subTotal;
  final num total;
  final num totalReceived;
  final String tableName;
  final String floorName;
  final String employeeName;
  final String guestName;
  final String depName;
  final bool isCancel;
  final String? refId;
  final Map<String, dynamic>? refDoc;

  SaleDataDetailReportModel({
    this.groupLabel,
    this.no,
    required this.orderNum,
    required this.refNo,
    required this.date,
    this.outDate,
    required this.type,
    required this.status,
    required this.discountRate,
    required this.discountValue,
    required this.subTotal,
    required this.total,
    required this.totalReceived,
    required this.tableName,
    required this.floorName,
    required this.employeeName,
    required this.guestName,
    required this.depName,
    required this.isCancel,
    this.refId,
    this.refDoc,
  });

  factory SaleDataDetailReportModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDataDetailReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleDataDetailReportModelToJson(this);
}
