// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleConfigModel _$SaleConfigModelFromJson(Map<String, dynamic> json) =>
    SaleConfigModel(
      editableInvoice: json['editableInvoice'] as bool?,
      requirePasswordForCopyInvoice:
          json['requirePasswordForCopyInvoice'] as bool?,
      displayTableAllDepartment: json['displayTableAllDepartment'] as bool?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SaleConfigModelToJson(SaleConfigModel instance) =>
    <String, dynamic>{
      'editableInvoice': instance.editableInvoice,
      'requirePasswordForCopyInvoice': instance.requirePasswordForCopyInvoice,
      'displayTableAllDepartment': instance.displayTableAllDepartment,
      'password': instance.password,
    };
