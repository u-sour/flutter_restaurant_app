import 'package:json_annotation/json_annotation.dart';
part 'setting_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingModel {
  final String ipAddress;
  final String? btPrinterName;
  final String? btPrinterAddress;
  String printerPaperSize;
  double printerFontSize;

  SettingModel({
    required this.ipAddress,
    this.btPrinterName,
    this.btPrinterAddress,
    required this.printerPaperSize,
    required this.printerFontSize,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$SettingModelToJson(this);

  set setPrinterPaperSize(String paperSize) {
    printerPaperSize = paperSize;
  }

  set setPrinterFontSize(double fontSize) {
    printerFontSize = fontSize;
  }
}
