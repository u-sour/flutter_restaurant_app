import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrinterStorage {
  // Create SharedPreferences
  final Future<SharedPreferences> _printerPrefs =
      SharedPreferences.getInstance();

  // Bluetooth Printer
  void setBTPrinter({required BluetoothDevice btPrinter}) async {
    SharedPreferences printerPrefs = await _printerPrefs;
    if (btPrinter.name != null && btPrinter.address.isNotEmpty) {
      printerPrefs.setString('btPrinterName', btPrinter.name!);
      printerPrefs.setString('btPrinterAddress', btPrinter.address);
    }
  }

  Future<BluetoothDevice> getBTPrinter() async {
    SharedPreferences printerPrefs = await _printerPrefs;
    return BluetoothDevice(
        name: printerPrefs.getString('btPrinterName'),
        address: printerPrefs.getString('btPrinterAddress') ?? "");
  }

  void clearBTPrinter() async {
    SharedPreferences printerPrefs = await _printerPrefs;
    printerPrefs.remove('btPrinterName');
    printerPrefs.remove('btPrinterAddress');
  }

  // Printer Paper Size
  void setPrinterPaperSize({required String paperSize}) async {
    SharedPreferences printerPrefs = await _printerPrefs;
    printerPrefs.setString('printerPaperSize', paperSize);
  }

  Future<String> getPrinterPaperSize() async {
    SharedPreferences printerPrefs = await _printerPrefs;
    return printerPrefs.getString('printerPaperSize') ?? "58mm";
  }

  void clearPrinterPaperSize() async {
    SharedPreferences printerPrefs = await _printerPrefs;
    printerPrefs.remove('printerPaperSize');
  }

  // Printer Font Size
  void setPrinterFontSize({required double fontSize}) async {
    SharedPreferences printerPrefs = await _printerPrefs;
    printerPrefs.setDouble('printerFontSize', fontSize);
  }

  Future<double> getPrinterFontSize() async {
    SharedPreferences printerPrefs = await _printerPrefs;
    return printerPrefs.getDouble('printerFontSize') ?? 20.0;
  }

  void clearPrinterFontSize() async {
    SharedPreferences printerPrefs = await _printerPrefs;
    printerPrefs.remove('printerFontSize');
  }
}
