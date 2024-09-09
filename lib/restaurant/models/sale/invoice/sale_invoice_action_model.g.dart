// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInvoiceActionModel _$SaleInvoiceActionModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleInvoiceActionModel(
    id: json['_id'] as String?,
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    type: json['type'] as String,
    status: json['status'] as String,
    statusDate: SaleInvoiceStatusDateModel.fromJson(
        json['statusDate'] as Map<String, dynamic>),
    discountRate: json['discountRate'] as num,
    discountValue: json['discountValue'] as num,
    total: json['total'] as num,
    totalReceived: json['totalReceived'] as num,
    tableId: json['tableId'] as String,
    depId: json['depId'] as String,
    employeeId: json['employeeId'] as String,
    guestId: json['guestId'] as String,
    numOfGuest: (json['numOfGuest'] as num).toInt(),
    billed: (json['billed'] as num).toInt(),
    branchId: json['branchId'] as String,
  );
}

Map<String, dynamic> _$SaleInvoiceActionModelToJson(
    SaleInvoiceActionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['date'] = DateModelConverter.convertDateTimeForModel(instance.date);
  val['type'] = instance.type;
  val['status'] = instance.status;
  val['statusDate'] = instance.statusDate.toJson();
  val['discountRate'] = instance.discountRate;
  val['discountValue'] = instance.discountValue;
  val['total'] = instance.total;
  val['totalReceived'] = instance.totalReceived;
  val['tableId'] = instance.tableId;
  val['depId'] = instance.depId;
  val['employeeId'] = instance.employeeId;
  val['guestId'] = instance.guestId;
  val['numOfGuest'] = instance.numOfGuest;
  val['billed'] = instance.billed;
  val['branchId'] = instance.branchId;
  return val;
}
