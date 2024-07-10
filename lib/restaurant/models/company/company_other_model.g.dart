// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_other_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyOtherModel _$CompanyOtherModelFromJson(Map<String, dynamic> json) =>
    CompanyOtherModel(
      dateFormat: json['dateFormat'] as String,
      lang: json['lang'] as String,
      inactiveInMinute: (json['inactiveInMinute'] as num).toInt(),
    );

Map<String, dynamic> _$CompanyOtherModelToJson(CompanyOtherModel instance) =>
    <String, dynamic>{
      'dateFormat': instance.dateFormat,
      'lang': instance.lang,
      'inactiveInMinute': instance.inactiveInMinute,
    };
