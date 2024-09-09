import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'sale_invoice_status_date_model.dart';
part 'sale_invoice_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleInvoiceDataModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime date;
  final String type;
  final String status;
  final SaleInvoiceStatusDateModel statusDate;
  final num discountRate;
  final num discountValue;
  final num total;
  final num totalReceived;
  final String tableId;
  final String employeeId;
  final String guestId;
  final int numOfGuest;
  final int billed;
  final String guestName;
  final String tableName;
  final String orderNum;
  final String refNo;
  final String branchId;
  final bool receiptId;
  final bool? requestPayment;

  const SaleInvoiceDataModel({
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
    required this.employeeId,
    required this.guestId,
    required this.numOfGuest,
    required this.billed,
    required this.guestName,
    required this.tableName,
    required this.orderNum,
    required this.refNo,
    required this.branchId,
    required this.receiptId,
    this.requestPayment,
  });

  factory SaleInvoiceDataModel.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInvoiceDataModelToJson(this);
}
