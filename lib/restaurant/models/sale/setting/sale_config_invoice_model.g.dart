// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_config_invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleConfigInvoiceModel _$SaleConfigInvoiceModelFromJson(
        Map<String, dynamic> json) =>
    SaleConfigInvoiceModel(
      companyName: json['companyName'] as String?,
      address: json['address'] as String?,
      telephone: json['telephone'] as String?,
      facebook: json['facebook'] as String?,
      thankText: json['thankText'] as String?,
      wifiPass: json['wifiPass'] as String?,
      footerAddress: json['footerAddress'] as String?,
      spaceLeft: (json['spaceLeft'] as num?)?.toInt(),
      spaceRight: (json['spaceRight'] as num?)?.toInt(),
      paperSize: json['paperSize'] as String?,
      copyForChef: (json['copyForChef'] as num?)?.toInt(),
      copyForBill: (json['copyForBill'] as num?)?.toInt(),
      copyForPayment: (json['copyForPayment'] as num?)?.toInt(),
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$SaleConfigInvoiceModelToJson(
        SaleConfigInvoiceModel instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'address': instance.address,
      'telephone': instance.telephone,
      'facebook': instance.facebook,
      'thankText': instance.thankText,
      'wifiPass': instance.wifiPass,
      'footerAddress': instance.footerAddress,
      'spaceLeft': instance.spaceLeft,
      'spaceRight': instance.spaceRight,
      'paperSize': instance.paperSize,
      'copyForChef': instance.copyForChef,
      'copyForBill': instance.copyForBill,
      'copyForPayment': instance.copyForPayment,
      'logo': instance.logo,
    };
