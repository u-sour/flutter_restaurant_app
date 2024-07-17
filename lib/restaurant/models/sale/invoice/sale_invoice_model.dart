import 'package:json_annotation/json_annotation.dart';
import 'sale_invoice_data_model.dart';
part 'sale_invoice_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleInvoiceModel {
  final List<SaleInvoiceDataModel> data;
  final int totalRecords;

  const SaleInvoiceModel({
    required this.data,
    required this.totalRecords,
  });

  factory SaleInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInvoiceModelToJson(this);
}
