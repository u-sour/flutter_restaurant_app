import 'package:json_annotation/json_annotation.dart';
import '../../../exchange/exchange_model.dart';
import '../../../invoice-template/invoice_template_model.dart';
import '../../detail/sale_detail_model.dart';
import 'sale_invoice_for_print_model.dart';
import 'convert_to_multi_exchange_model.dart';
import 'sale_receipt_for_print_model.dart';
part 'sale_invoice_content_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleInvoiceContentModel {
  final SaleInvoiceForPrintModel saleDoc;
  final List<SaleDetailModel> orderList;
  final ExchangeModel exchangeDoc;
  final List<String> allowedCurrencies;
  final String baseCurrency;
  final SaleReceiptForPrintModel? receiptDoc;
  final num subTotal;
  final ConvertToMultiExchangeModel totalAmountExchange;
  final num feeAmount;
  final num prevReceiveAmount;
  final ConvertToMultiExchangeModel? receiveAmountExchange;
  final ConvertToMultiExchangeModel? returnAmountExchange;
  final String? returnAmountType;
  final InvoiceTemplateModel templateDoc;
  final String templateMargin;

  const SaleInvoiceContentModel({
    required this.saleDoc,
    required this.orderList,
    required this.exchangeDoc,
    required this.allowedCurrencies,
    required this.baseCurrency,
    this.receiptDoc,
    required this.subTotal,
    required this.totalAmountExchange,
    required this.feeAmount,
    required this.prevReceiveAmount,
    this.receiveAmountExchange,
    this.returnAmountExchange,
    this.returnAmountType,
    required this.templateDoc,
    required this.templateMargin,
  });

  factory SaleInvoiceContentModel.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInvoiceContentModelToJson(this);
}
