import 'package:json_annotation/json_annotation.dart';
part 'sale_config_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleConfigModel {
  final bool? editableInvoice;
  final bool? requirePasswordForCopyInvoice;
  final bool? displayTableAllDepartment;
  final String? password;

  const SaleConfigModel({
    this.editableInvoice,
    this.requirePasswordForCopyInvoice,
    this.displayTableAllDepartment,
    this.password,
  });

  factory SaleConfigModel.fromJson(Map<String, dynamic> json) =>
      _$SaleConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleConfigModelToJson(this);
}
