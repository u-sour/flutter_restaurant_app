import 'package:json_annotation/json_annotation.dart';
part 'company_accounting_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyAccountingModel {
  final String baseCurrency;
  final int decimalNumber;
  final bool accountingIntegration;
  final List<String> allowedCurrencies;

  const CompanyAccountingModel({
    required this.baseCurrency,
    required this.decimalNumber,
    required this.accountingIntegration,
    required this.allowedCurrencies,
  });

  factory CompanyAccountingModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyAccountingModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyAccountingModelToJson(this);
}
