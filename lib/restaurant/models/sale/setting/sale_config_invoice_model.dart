import 'package:json_annotation/json_annotation.dart';
part 'sale_config_invoice_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleConfigInvoiceModel {
  final String? companyName;
  final String? address;
  final String? telephone;
  final String? facebook;
  final String? thankText;
  final String? wifiPass;
  final String? footerAddress;
  final int? spaceLeft;
  final int? spaceRight;
  final String? paperSize;
  final int? copyForChef;
  final int? copyForBill;
  final int? copyForPayment;
  final String? logo;

  const SaleConfigInvoiceModel({
    this.companyName,
    this.address,
    this.telephone,
    this.facebook,
    this.thankText,
    this.wifiPass,
    this.footerAddress,
    this.spaceLeft,
    this.spaceRight,
    this.paperSize,
    this.copyForChef,
    this.copyForBill,
    this.copyForPayment,
    this.logo,
  });

  factory SaleConfigInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$SaleConfigInvoiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleConfigInvoiceModelToJson(this);
}
