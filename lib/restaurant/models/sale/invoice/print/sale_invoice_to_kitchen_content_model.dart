import 'package:json_annotation/json_annotation.dart';
import '../../detail/sale_detail_model.dart';
import 'order_list_by_station_model.dart';
part 'sale_invoice_to_kitchen_content_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleInvoiceToKitchenContentModel {
  final String templateMargin;
  final String orderNum;
  final String tableId;
  final String tableName;
  final List<SaleDetailModel> orderList;
  final List<OrderListByStationModel> orderListByStation;

  const SaleInvoiceToKitchenContentModel({
    required this.templateMargin,
    required this.orderNum,
    required this.tableId,
    required this.tableName,
    required this.orderList,
    required this.orderListByStation,
  });

  factory SaleInvoiceToKitchenContentModel.fromJson(
          Map<String, dynamic> json) =>
      _$SaleInvoiceToKitchenContentModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SaleInvoiceToKitchenContentModelToJson(this);
}
