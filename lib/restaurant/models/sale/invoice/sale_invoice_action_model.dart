import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'sale_invoice_status_date_model.dart';
part 'sale_invoice_action_model.g.dart';

/*
  Note: this model for insert or update sale
*/
@JsonSerializable(explicitToJson: true)
class SaleInvoiceActionModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String? id;
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
  final String depId;
  final String employeeId;
  final String guestId;
  final int numOfGuest;
  final int billed;
  final String branchId;

  const SaleInvoiceActionModel({
    this.id,
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
    required this.guestId,
    required this.numOfGuest,
    required this.billed,
    required this.branchId,
  });

  factory SaleInvoiceActionModel.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceActionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInvoiceActionModelToJson(this);
}
