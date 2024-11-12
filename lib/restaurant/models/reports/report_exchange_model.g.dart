// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_exchange_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportExchangeModel _$ReportExchangeModelFromJson(Map<String, dynamic> json) =>
    ReportExchangeModel(
      khr: json['KHR'] as num,
      usd: json['USD'] as num,
      thb: json['THB'] as num,
    );

Map<String, dynamic> _$ReportExchangeModelToJson(
        ReportExchangeModel instance) =>
    <String, dynamic>{
      'KHR': instance.khr,
      'USD': instance.usd,
      'THB': instance.thb,
    };
