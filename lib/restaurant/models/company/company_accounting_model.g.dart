// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_accounting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyAccountingModel _$CompanyAccountingModelFromJson(
        Map<String, dynamic> json) =>
    CompanyAccountingModel(
      baseCurrency: json['baseCurrency'] as String,
      decimalNumber: (json['decimalNumber'] as num).toInt(),
      accountingIntegration: json['accountingIntegration'] as bool,
      allowedCurrencies: (json['allowedCurrencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CompanyAccountingModelToJson(
        CompanyAccountingModel instance) =>
    <String, dynamic>{
      'baseCurrency': instance.baseCurrency,
      'decimalNumber': instance.decimalNumber,
      'accountingIntegration': instance.accountingIntegration,
      'allowedCurrencies': instance.allowedCurrencies,
    };
