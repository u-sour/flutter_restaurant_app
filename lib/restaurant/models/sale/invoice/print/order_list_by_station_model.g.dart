// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_by_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListByStationModel _$OrderListByStationModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return OrderListByStationModel(
    id: json['_id'] as String,
    singlePrint: json['singlePrint'] as bool,
    ipAddress: json['ipAddress'] as String?,
    details: (json['details'] as List<dynamic>)
        .map((e) => SaleDetailInvoiceToKitchenForPrintModel.fromJson(
            e as Map<String, dynamic>))
        .toList(),
    devices: (json['devices'] as List<dynamic>?)
        ?.map((e) => PrinterDeviceModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderListByStationModelToJson(
        OrderListByStationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'singlePrint': instance.singlePrint,
      'ipAddress': instance.ipAddress,
      'details': instance.details.map((e) => e.toJson()).toList(),
      'devices': instance.devices?.map((e) => e.toJson()).toList(),
    };
