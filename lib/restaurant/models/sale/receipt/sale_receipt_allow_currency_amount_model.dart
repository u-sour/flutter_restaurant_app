import 'package:json_annotation/json_annotation.dart';
part 'sale_receipt_allow_currency_amount_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleReceiptAllowCurrencyAmountModel {
  final num khr;
  final num usd;
  final num thb;

  const SaleReceiptAllowCurrencyAmountModel(
      {required this.khr, required this.usd, required this.thb});

  factory SaleReceiptAllowCurrencyAmountModel.fromJson(
          Map<String, dynamic> json) =>
      _$SaleReceiptAllowCurrencyAmountModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SaleReceiptAllowCurrencyAmountModelToJson(this);
}
