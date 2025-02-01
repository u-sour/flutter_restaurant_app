import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/app_screen.dart';
import '../../../storages/connection_storage.dart';
import '../../models/sale/invoice/print/sale_invoice_content_model.dart';
import '../../models/sale/invoice/print/sale_invoice_to_kitchen_content_model.dart';

class InvoiceProvider extends ChangeNotifier {
  late String _ipAddress;
  String get ipAddress => _ipAddress;

  InvoiceProvider() {
    initData();
  }

  void initData() async {
    _ipAddress = (await ConnectionStorage().getIpAddress())!;
    notifyListeners();
  }

  // Print
  // fetch sale invoice content
  Future<SaleInvoiceContentModel> fetchInvoiceContentData(
      {required String invoiceId,
      required String branchId,
      String? receiptId,
      required bool receiptPrint,
      bool? isTotal,
      bool? isRepaid,
      required BuildContext context}) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    final String employeeId = readAppProvider.currentUser!.id;

    Map<String, dynamic> selector = {
      'invoiceId': invoiceId,
      'branchId': branchId,
      'receiptId': receiptId,
      'employeeId': receiptPrint == false ? null : employeeId,
      'isTotal': isTotal,
      'isRepaid': isRepaid
    };
    Map<String, dynamic> result =
        await meteor.call('rest.fetchInvoiceContent', args: [selector]);
    SaleInvoiceContentModel toModel = SaleInvoiceContentModel.fromJson(result);
    return toModel;
  }

  // fetch printers
  Future<List<dynamic>> fetchPrinterGroupByIP(
      {required List<String> printerIds}) async {
    Map<String, dynamic> selector = {'_ids': printerIds};
    List<dynamic> result =
        await meteor.call('rest.findPrinterGroupByIP', args: [selector]);
    return result;
  }

  // fetch print to kitchen info
  Future<SaleInvoiceToKitchenContentModel> fetchPrintToKitchenInfo(
      {required String branchId,
      required String invoiceId,
      required List<String> saleDetailIds,
      required bool isMultiPrint}) async {
    late SaleInvoiceToKitchenContentModel toModel;
    Map<String, dynamic> selector = {
      'branchId': branchId,
      'invoiceId': invoiceId,
      'itemIds': saleDetailIds,
      'isMultiPrint': isMultiPrint
    };
    final Map<String, dynamic> result =
        await meteor.call('rest.getPrintToKitchenInfo', args: [selector]);
    toModel = SaleInvoiceToKitchenContentModel.fromJson(result);
    return toModel;
  }
}
