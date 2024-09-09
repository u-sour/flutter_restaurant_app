import 'package:json_annotation/json_annotation.dart';
import '../../exchange/exchange_model.dart';
import '../sale/sale_model.dart';
part 'sale_receipt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleReceiptModel {
  final ExchangeModel exchangeDoc;
  final SaleModel orderDoc;

  const SaleReceiptModel({required this.exchangeDoc, required this.orderDoc});

  factory SaleReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$SaleReceiptModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleReceiptModelToJson(this);
}
