import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import '../models/servers/response_model.dart';
import '../storages/printer_storage.dart';
import '../utils/alert/awesome_snack_bar_utils.dart';

class PrinterProvider extends ChangeNotifier {
  late ReceiptController controller;
  double _progress = 0;
  final String _alertPrefix = 'screens.printer.alert';

  //getter
  double get progress => _progress;

  Future<ResponseModel> btPrinterPrinting({int addFeeds = 2}) async {
    final PrinterStorage printerStorage = PrinterStorage();
    final BluetoothDevice btPrinter = await printerStorage.getBTPrinter();
    final String printerPaperSize = await printerStorage.getPrinterPaperSize();
    ResponseModel result = ResponseModel(
        status: 201,
        message: '$_alertPrefix.success.message',
        type: AWESOMESNACKBARTYPE.success);

    //check bluetooth printer address exist or not
    if (btPrinter.address.isNotEmpty) {
      //check & set printer paper size
      late PaperSize paperSize;
      switch (printerPaperSize) {
        case '80mm':
          paperSize = PaperSize.mm58;
          break;
        default:
          paperSize = PaperSize.mm58;
      }
      controller.paperSize = paperSize;
      // start printing
      final printed = await controller.print(
        address: btPrinter.address,
        addFeeds: addFeeds,
        keepConnected: true,
        onProgress: (total, sent) {
          _progress = sent / total;
          notifyListeners();
        },
      );
      if (!printed) {
        result = ResponseModel(
            status: 404,
            message: '$_alertPrefix.off.message',
            type: AWESOMESNACKBARTYPE.failure);
      }
    } else {
      result = ResponseModel(
          status: 404,
          message: '$_alertPrefix.notFound.message',
          type: AWESOMESNACKBARTYPE.failure);
    }

    return result;
  }
}
