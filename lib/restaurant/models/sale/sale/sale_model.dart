import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'sale_status_date_model.dart';
part 'sale_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String type;
  final String status;
  final SaleStatusDateModel statusDate;
  final num discountRate;
  final num discountValue;
  final num total;
  final num totalReceived;
  final String tableId;
  final String depId;
  final String employeeId;
  final String? employeeName;
  final String guestId;
  final String? guestName;
  final int numOfGuest;
  final int billed;
  final String branchId;
  final String? refId;
  final String refNo;
  final String orderNum;
  @JsonKey(disallowNullValue: true)
  final bool? requestPayment;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime createdAt;
  final String createdBy;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeOptionalForModel,
      toJson: DateModelConverter.convertDateTimeOptionalForModel)
  final DateTime? updatedAt;
  final String? updatedBy;

  const SaleModel({
    required this.id,
    required this.date,
    required this.type,
    required this.status,
    required this.statusDate,
    required this.discountRate,
    required this.discountValue,
    required this.total,
    required this.totalReceived,
    required this.tableId,
    required this.depId,
    required this.employeeId,
    this.employeeName,
    required this.guestId,
    this.guestName,
    required this.numOfGuest,
    required this.billed,
    required this.branchId,
    this.refId,
    required this.refNo,
    required this.orderNum,
    this.requestPayment,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);
}
