import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter_template/storages/connection_storage.dart';
import 'package:flutter_template/storages/printer_storage.dart';
import '../models/setting/setting_model.dart';

class SettingProvider extends ChangeNotifier {
  late SettingModel _settingDoc;
  bool _loading = false;
  BluetoothDevice? _selectedBTDevice;

  // getter
  SettingModel get settingDoc => _settingDoc;
  bool get loading => _loading;
  BluetoothDevice? get selectedBTDevice => _selectedBTDevice;

  void initState() async {
    _loading = true;
    PrinterStorage printerStorage = PrinterStorage();
    String ipAddress = await ConnectionStorage().getIpAddress() ?? "";
    BluetoothDevice btPrinter = await printerStorage.getBTPrinter();
    String printerPaperSize = await printerStorage.getPrinterPaperSize();
    double printerFontSize = await printerStorage.getPrinterFontSize();
    // _settingDoc
    _settingDoc = SettingModel(
      ipAddress: ipAddress,
      btPrinterName: btPrinter.name,
      btPrinterAddress: btPrinter.address,
      printerPaperSize: printerPaperSize,
      printerFontSize: printerFontSize,
    );
    _loading = false;
    notifyListeners();
  }

  void searchAndSelectBluetoothDevice(BuildContext context) async {
    _selectedBTDevice = await FlutterBluetoothPrinter.selectDevice(context);
    if (_selectedBTDevice != null) {
      setBTPrinter(btPrinter: _selectedBTDevice!);
    }
  }

  void disconnectSelectedBluetoothDevice() async {
    _loading = true;
    PrinterStorage printerStorage = PrinterStorage();
    BluetoothDevice btPrinter = await printerStorage.getBTPrinter();
    if (btPrinter.address.isNotEmpty) {
      // disconnect bluetooth device
      await FlutterBluetoothPrinter.disconnect(btPrinter.address);
      // unset bluetooth printer data from setting doc state
      _settingDoc.setBTPrinter = BluetoothDevice(name: '', address: '');
      // clear bluetooth printer data from storage
      printerStorage.clearBTPrinter();
    }
    _loading = false;
    notifyListeners();
  }

  void setBTPrinter({required BluetoothDevice btPrinter}) {
    // set into storage
    PrinterStorage printerStorage = PrinterStorage();
    printerStorage.setBTPrinter(btPrinter: btPrinter);
    // set setting doc state
    _settingDoc.setBTPrinter = btPrinter;
    notifyListeners();
  }

  void setPrinterPaperSize({required String paperSize}) {
    // set into storage
    PrinterStorage printerStorage = PrinterStorage();
    printerStorage.setPrinterPaperSize(paperSize: paperSize);
    // set setting doc state
    _settingDoc.setPrinterPaperSize = paperSize;
    notifyListeners();
  }

  void setPrinterFontSize({required double fontSize}) {
    // set into storage
    PrinterStorage printerStorage = PrinterStorage();
    printerStorage.setPrinterFontSize(fontSize: fontSize);
    // set setting doc state
    _settingDoc.setPrinterFontSize = fontSize;
    notifyListeners();
  }
}
