import 'package:json_annotation/json_annotation.dart';
part 'printer_device_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PrinterDeviceModel {
  final String name;
  final String spacing;

  const PrinterDeviceModel({
    required this.name,
    required this.spacing,
  });

  factory PrinterDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$PrinterDeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$PrinterDeviceModelToJson(this);
}
