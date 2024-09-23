// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_to_multi_exchange_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertToMultiExchangeModel _$ConvertToMultiExchangeModelFromJson(
        Map<String, dynamic> json) =>
    ConvertToMultiExchangeModel(
      khr: json['KHR'] as num,
      usd: json['USD'] as num,
      thb: json['THB'] as num,
    );

Map<String, dynamic> _$ConvertToMultiExchangeModelToJson(
        ConvertToMultiExchangeModel instance) =>
    <String, dynamic>{
      'KHR': instance.khr,
      'USD': instance.usd,
      'THB': instance.thb,
    };
