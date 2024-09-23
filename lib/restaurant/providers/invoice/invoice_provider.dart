import 'package:big_dart/big_dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/app_screen.dart';
import '../../../storages/connection_storage.dart';
import '../../models/sale/detail/sale_detail_model.dart';
import '../../models/sale/invoice/print/sale_invoice_content_model.dart';
import '../../utils/round_number.dart';

class InvoiceProvider extends ChangeNotifier {
  late String _ipAddress;
  String get ipAddress => _ipAddress;
  // late String _baseCurrency;
  // String get baseCurrency => _baseCurrency;
  // late int _decimalNumber;
  // int get decimalNumber => _decimalNumber;
  // late RoundNumber _roundNumber;

  void initData({required BuildContext context}) async {
    // AppProvider readAppProvider = context.read<AppProvider>();
    // _baseCurrency = readAppProvider.companyAccounting.baseCurrency;
    // _decimalNumber = readAppProvider.companyAccounting.decimalNumber;
    // _roundNumber = RoundNumber(
    //     decimalNumber: _baseCurrency == 'KHR' ? -decimalNumber : decimalNumber);
    _ipAddress = (await ConnectionStorage().getIpAddress())!;
    notifyListeners();
  }

  // Print
  // fetch sale invoice content
  Future<SaleInvoiceContentModel> fetchInvoiceContentData(
      {required String invoiceId,
      String? receiptId,
      required bool receiptPrint,
      bool? isTotal,
      bool? isRepaid,
      required BuildContext context}) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    final String employeeId = readAppProvider.currentUser!.id;

    Map<String, dynamic> selector = {
      'invoiceId': invoiceId,
      'receiptId': receiptId,
      'employeeId': receiptPrint == false ? null : employeeId,
      'isTotal': isTotal,
      'isRepaid': isRepaid
    };
    Map<String, dynamic> result =
        await meteor.call('rest.mobile.fetchInvoiceContent', args: [selector]);
    SaleInvoiceContentModel toModel = SaleInvoiceContentModel.fromJson(result);
    return toModel;
  }
}
