import 'package:big_dart/big_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/models/exchange/exchange_model.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/app_screen.dart';
import '../../models/sale/detail/sale_detail_model.dart';
import '../../models/sale/invoice/sale_invoice_for_print_model.dart';
import '../../utils/round_number.dart';

class InvoiceProvider extends ChangeNotifier {
  late String _baseCurrency;
  String get baseCurrency => _baseCurrency;
  late int _decimalNumber;
  int get decimalNumber => _decimalNumber;
  late RoundNumber _roundNumber;

  void initData({required BuildContext context}) {
    AppProvider readAppProvider = context.read<AppProvider>();
    _baseCurrency = readAppProvider.companyAccounting.baseCurrency;
    _decimalNumber = readAppProvider.companyAccounting.decimalNumber;
    _roundNumber = RoundNumber(
        decimalNumber: _baseCurrency == 'KHR' ? -decimalNumber : decimalNumber);
    notifyListeners();
  }

  // Print
  // fetch sale
  Future<SaleInvoiceForPrintModel> fetchInvoiceData(
      {required String invoiceId,
      bool receiptPrint = false,
      required BuildContext context}) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    final String employeeId = readAppProvider.currentUser!.id;
    Map<String, dynamic> selector = {
      '_id': invoiceId,
      'employeeId': receiptPrint ? null : employeeId
    };
    Map<String, dynamic> result =
        await meteor.call('rest.findSaleInvoiceData', args: [selector]);
    SaleInvoiceForPrintModel toModel =
        SaleInvoiceForPrintModel.fromJson(result);
    return toModel;
  }

  // fetch Sale Detail
  Future<List<SaleDetailModel>> fetchSaleDetails(
      {required String invoiceId}) async {
    Map<String, dynamic> selector = {
      'invoiceId': invoiceId,
      'forInvoice': true
    };
    List<dynamic> result =
        await meteor.call('rest.findOrderList', args: [selector]);
    List<SaleDetailModel> toListModel = [];
    if (result.isNotEmpty) {
      toListModel =
          result.map((json) => SaleDetailModel.fromJson(json)).toList();
    }
    return toListModel;
  }

  // fetch
  Future<ExchangeModel> findOneExchange() async {
    Map<String, dynamic> selector = {};
    Map<String, dynamic> options = {
      'sort': {'exDate': -1}
    };
    final Map<String, dynamic> result =
        await meteor.call('app.findOneExchange', args: [
      {'selector': selector, 'options': options}
    ]);
    ExchangeModel toModel = ExchangeModel.fromJson(result);
    return toModel;
  }

  // subTotal
  num calculateSubTotal({required num total, required num discountValue}) {
    num subTotal = total + discountValue;
    return formatMoney(amount: subTotal, baseCurrency: _baseCurrency);
  }

  Map<String, num> calculateTotal({
    bool isRepaid = false,
    SaleInvoiceForPrintModel? sale,
  }) {
    Map<String, num> totalAmount = {'khr': 0, 'usd': 0, 'thb': 0};
    return totalAmount;
  }

  num formatMoney({required num amount, required String baseCurrency}) {
    return _roundNumber.round(
        value: amount,
        decimalNumber: baseCurrency == 'KHR' ? -_decimalNumber : _decimalNumber,
        roundingMode: baseCurrency == 'KHR' ? RoundingMode.roundUp : null);
  }
}
