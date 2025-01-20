import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:toastification/toastification.dart';
import '../models/servers/response_model.dart';
import '../storages/printer_storage.dart';

class PrinterProvider extends ChangeNotifier {
  late ReceiptController controller;
  late double _progress;
  double get progress => _progress;
  final String _alertPrefix = 'screens.printer.alert';

  void init() {
    _progress = 0.0;
  }

  Future<ResponseModel> btPrinterPrinting({int addFeeds = 5}) async {
    final PrinterStorage printerStorage = PrinterStorage();
    final BluetoothDevice btPrinter = await printerStorage.getBTPrinter();
    ResponseModel result = ResponseModel(
        status: 201,
        description: '$_alertPrefix.success.message',
        type: ToastificationType.success);

    //check bluetooth printer address exist or not
    if (btPrinter.address.isNotEmpty) {
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
            description: '$_alertPrefix.off.message',
            type: ToastificationType.error);
      }
    } else {
      result = ResponseModel(
          status: 404,
          description: '$_alertPrefix.notFound.message',
          type: ToastificationType.error);
    }

    return result;
  }
}
