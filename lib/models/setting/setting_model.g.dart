// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) => SettingModel(
      ipAddress: json['ipAddress'] as String,
      btPrinterName: json['btPrinterName'] as String?,
      btPrinterAddress: json['btPrinterAddress'] as String?,
      printerPaperSize: json['printerPaperSize'] as String,
      printerFontSize: (json['printerFontSize'] as num).toDouble(),
    );

Map<String, dynamic> _$SettingModelToJson(SettingModel instance) =>
    <String, dynamic>{
      'ipAddress': instance.ipAddress,
      'btPrinterName': instance.btPrinterName,
      'btPrinterAddress': instance.btPrinterAddress,
      'printerPaperSize': instance.printerPaperSize,
      'printerFontSize': instance.printerFontSize,
    };
