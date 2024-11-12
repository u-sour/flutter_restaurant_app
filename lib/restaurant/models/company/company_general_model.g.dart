// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_general_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyGeneralModel _$CompanyGeneralModelFromJson(Map<String, dynamic> json) =>
    CompanyGeneralModel(
      name: json['name'] as String,
      address: json['address'] as String,
      telephone: json['telephone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      industry: json['industry'] as String,
    );

Map<String, dynamic> _$CompanyGeneralModelToJson(
        CompanyGeneralModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'telephone': instance.telephone,
      'email': instance.email,
      'website': instance.website,
      'industry': instance.industry,
    };
