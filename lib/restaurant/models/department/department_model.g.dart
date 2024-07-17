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

Map<String, dynamic> _$DepartmentModelToJson(DepartmentModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'branchId': instance.branchId,
    'name': instance.name,
    'isolateInvoice': instance.isolateInvoice,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('printerForBill', instance.printerForBill);
  writeNotNull('printerForPayment', instance.printerForPayment);
  val['telephone'] = instance.telephone;
  val['createdAt'] =
      DateModelConverter.convertDateTimeForModel(instance.createdAt);
  writeNotNull('updatedAt',
      DateModelConverter.convertDateTimeOptionalForModel(instance.updatedAt));
  writeNotNull('updatedBy', instance.updatedBy);
  return val;
}
