// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      '_id',
      'requestPayment',
      'updatedAt',
      'updatedBy'
    ],
  );
  return SaleModel(
    id: json['_id'] as String,
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    type: json['type'] as String,
    status: json['status'] as String,
    statusDate: SaleStatusDateModel.fromJson(
        json['statusDate'] as Map<String, dynamic>),
    discountRate: json['discountRate'] as num,
    discountValue: json['discountValue'] as num,
    total: json['total'] as num,
    totalReceived: json['totalReceived'] as num,
    tableId: json['tableId'] as String,
    depId: json['depId'] as String,
    employeeId: json['employeeId'] as String,
    employeeName: json['employeeName'] as String?,
    guestId: json['guestId'] as String,
    numOfGuest: (json['numOfGuest'] as num).toInt(),
    billed: (json['billed'] as num).toInt(),
    branchId: json['branchId'] as String,
    refId: json['refId'] as String?,
    refNo: json['refNo'] as String,
    orderNum: json['orderNum'] as String,
    requestPayment: json['requestPayment'] as bool?,
    createdAt: DateModelConverter.convertDateTimeForModel(
        json['createdAt'] as DateTime),
    createdBy: json['createdBy'] as String,
    updatedAt: DateModelConverter.convertDateTimeOptionalForModel(
        json['updatedAt'] as DateTime?),
    updatedBy: json['updatedBy'] as String?,
  );
}

Map<String, dynamic> _$SaleModelToJson(SaleModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'date': DateModelConverter.convertDateTimeForModel(instance.date),
    'type': instance.type,
    'status': instance.status,
    'statusDate': instance.statusDate.toJson(),
    'discountRate': instance.discountRate,
    'discountValue': instance.discountValue,
    'total': instance.total,
    'totalReceived': instance.totalReceived,
    'tableId': instance.tableId,
    'depId': instance.depId,
    'employeeId': instance.employeeId,
    'employeeName': instance.employeeName,
    'guestId': instance.guestId,
    'numOfGuest': instance.numOfGuest,
    'billed': instance.billed,
    'branchId': instance.branchId,
    'refId': instance.refId,
    'refNo': instance.refNo,
    'orderNum': instance.orderNum,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestPayment', instance.requestPayment);
  val['createdAt'] =
      DateModelConverter.convertDateTimeForModel(instance.createdAt);
  val['createdBy'] = instance.createdBy;
  writeNotNull('updatedAt',
      DateModelConverter.convertDateTimeOptionalForModel(instance.updatedAt));
  writeNotNull('updatedBy', instance.updatedBy);
  return val;
}
