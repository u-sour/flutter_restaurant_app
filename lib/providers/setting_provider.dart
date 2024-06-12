import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter_template/storages/connection_storage.dart';
import 'package:flutter_template/storages/printer_storage.dart';
import '../models/setting/setting_model.dart';

class SettingProvider extends ChangeNotifier {
  late SettingModel _settingDoc;
  bool _loading = false;
  bool _isSearchingBTDevices = false;
  BluetoothDevice? _bluetoothDevices;

  // getter
  SettingModel get settingDoc => _settingDoc;
  bool get loading => _loading;
  bool get isSearchingBTDevices => _isSearchingBTDevices;
  BluetoothDevice? get bluetoothDevices => _bluetoothDevices;

  void initState() async {
    _loading = true;
    String ipAddress = await ConnectionStorage().getIpAddress() ?? "";
    String printerPaperSize = await PrinterStorage().getPrinterPaperSize();
    double printerFontSize = await PrinterStorage().getPrinterFontSize();
    // _settingDoc
    _settingDoc = SettingModel(
      ipAddress: ipAddress,
      printerPaperSize: printerPaperSize,
      printerFontSize: printerFontSize,
    );
    _loading = false;
    notifyListeners();
  }

  void searchBluetoothDevices(BuildContext context) async {
    _isSearchingBTDevices = true;
    notifyListeners();
    _bluetoothDevices = await FlutterBluetoothPrinter.selectDevice(context);
    print(_bluetoothDevices);
    _isSearchingBTDevices = false;
    notifyListeners();
  }

  void setPrinterPaperSize({required String paperSize}) {
    PrinterStorage printerStorage = PrinterStorage();
    printerStorage.setPrinterPaperSize(paperSize: paperSize);
    _settingDoc.setPrinterPaperSize = paperSize;
    notifyListeners();
  }

  void setPrinterFontSize({required double fontSize}) {
    PrinterStorage printerStorage = PrinterStorage();
    printerStorage.setPrinterFontSize(fontSize: fontSize);
    _settingDoc.setPrinterFontSize = fontSize;
    notifyListeners();
  }
}
