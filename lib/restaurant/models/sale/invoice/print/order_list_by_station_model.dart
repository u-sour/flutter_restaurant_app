import 'package:json_annotation/json_annotation.dart';
import 'printer_device_model.dart';
import 'sale_detail_invoice_to_kitchen_for_print_model.dart';
part 'order_list_by_station_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderListByStationModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final bool singlePrint;
  final String? ipAddress;
  final List<SaleDetailInvoiceToKitchenForPrintModel> details;
  final List<PrinterDeviceModel>? devices;

  const OrderListByStationModel({
    required this.id,
    required this.singlePrint,
    this.ipAddress,
    required this.details,
    this.devices,
  });

  factory OrderListByStationModel.fromJson(Map<String, dynamic> json) =>
      _$OrderListByStationModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListByStationModelToJson(this);
}
