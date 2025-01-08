// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      '_id',
      'currentGuestCount',
      'currentInvoiceCount',
      'status'
    ],
  );
  return TableModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    floorId: json['floorId'] as String,
    floorName: json['floorName'] as String,
    numOfGuest: (json['numOfGuest'] as num).toInt(),
    branchId: json['branchId'] as String,
    department:
        DepartmentModel.fromJson(json['department'] as Map<String, dynamic>),
    label: json['label'] as String,
    location: json['location'] as String,
    order: json['order'] as String,
    currentGuestCount: (json['currentGuestCount'] as num?)?.toInt(),
    currentInvoiceCount: (json['currentInvoiceCount'] as num?)?.toInt(),
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'floorId': instance.floorId,
      'floorName': instance.floorName,
      'numOfGuest': instance.numOfGuest,
      'branchId': instance.branchId,
      'department': instance.department.toJson(),
      'label': instance.label,
      'location': instance.location,
      'order': instance.order,
      if (instance.currentGuestCount case final value?)
        'currentGuestCount': value,
      if (instance.currentInvoiceCount case final value?)
        'currentInvoiceCount': value,
      if (instance.status case final value?) 'status': value,
    };
