import 'package:json_annotation/json_annotation.dart';
import '../../../utils/model_converter/date_model_converter.dart';
part 'sale_invoice_status_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleInvoiceStatusDateModel {
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime open;
  const SaleInvoiceStatusDateModel({required this.open});

  factory SaleInvoiceStatusDateModel.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceStatusDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInvoiceStatusDateModelToJson(this);
}
