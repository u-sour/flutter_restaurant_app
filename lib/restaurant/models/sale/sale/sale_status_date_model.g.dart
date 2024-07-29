// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_status_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleStatusDateModel _$SaleStatusDateModelFromJson(Map<String, dynamic> json) =>
    SaleStatusDateModel(
      open:
          DateModelConverter.convertDateTimeForModel(json['open'] as DateTime),
    );

Map<String, dynamic> _$SaleStatusDateModelToJson(
        SaleStatusDateModel instance) =>
    <String, dynamic>{
      'open': DateModelConverter.convertDateTimeForModel(instance.open),
    };
