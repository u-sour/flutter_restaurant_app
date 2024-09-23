import 'package:json_annotation/json_annotation.dart';
import '../../../../../utils/model_converter/date_model_converter.dart';
part 'sale_invoice_for_print_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleInvoiceForPrintModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String tableId;
  final String tableName;
  final String floorName;
  final String guestName;
  final String employeeName;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String status;
  final num discountRate;
  final num discountValue;
  final num total;
  final num totalReceived;
  final String orderNum;
  final String refNo;
  final String branchId;

  const SaleInvoiceForPrintModel({
    required this.id,
    required this.tableId,
    required this.guestName,
    required this.employeeName,
    required this.tableName,
    required this.floorName,
    required this.date,
    required this.status,
    required this.discountRate,
    required this.discountValue,
    required this.total,
    required this.totalReceived,
    required this.orderNum,
    required this.refNo,
    required this.branchId,
  });

  factory SaleInvoiceForPrintModel.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceForPrintModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInvoiceForPrintModelToJson(this);
}
