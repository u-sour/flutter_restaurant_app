// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentModel _$DepartmentModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      '_id',
      'printerForBill',
      'printerForPayment',
      'updatedAt',
      'updatedBy'
    ],
  );
  return DepartmentModel(
    id: json['_id'] as String,
    branchId: json['branchId'] as String,
    name: json['name'] as String,
    isolateInvoice: json['isolateInvoice'] as bool?,
    printerForBill: (json['printerForBill'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    printerForPayment: (json['printerForPayment'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    telephone: json['telephone'] as String?,
    createdAt: DateModelConverter.convertDateTimeForModel(
        json['createdAt'] as DateTime),
    updatedAt: DateModelConverter.convertDateTimeOptionalForModel(
        json['updatedAt'] as DateTime?),
    updatedBy: json['updatedBy'] as String?,
  );
}

Map<String, dynamic> _$DepartmentModelToJson(DepartmentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'branchId': instance.branchId,
      'name': instance.name,
      'isolateInvoice': instance.isolateInvoice,
      if (instance.printerForBill case final value?) 'printerForBill': value,
      if (instance.printerForPayment case final value?)
        'printerForPayment': value,
      'telephone': instance.telephone,
      'createdAt':
          DateModelConverter.convertDateTimeForModel(instance.createdAt),
      if (DateModelConverter.convertDateTimeOptionalForModel(instance.updatedAt)
          case final value?)
        'updatedAt': value,
      if (instance.updatedBy case final value?) 'updatedBy': value,
    };
