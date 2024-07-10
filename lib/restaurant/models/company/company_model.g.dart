// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return CompanyModel(
    id: json['_id'] as String,
    general:
        CompanyGeneralModel.fromJson(json['general'] as Map<String, dynamic>),
    accounting: CompanyAccountingModel.fromJson(
        json['accounting'] as Map<String, dynamic>),
    other: CompanyOtherModel.fromJson(json['other'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'general': instance.general.toJson(),
      'accounting': instance.accounting.toJson(),
      'other': instance.other.toJson(),
    };
