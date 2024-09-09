// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeModel _$ExchangeModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return ExchangeModel(
    id: json['_id'] as String,
    base: json['base'] as String,
    exDate:
        DateModelConverter.convertDateTimeForModel(json['exDate'] as DateTime),
    khr: (json['khr'] as num).toInt(),
    thb: (json['thb'] as num).toInt(),
    usd: (json['usd'] as num).toInt(),
  );
}

Map<String, dynamic> _$ExchangeModelToJson(ExchangeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'base': instance.base,
      'exDate': DateModelConverter.convertDateTimeForModel(instance.exDate),
      'khr': instance.khr,
      'thb': instance.thb,
      'usd': instance.usd,
    };
