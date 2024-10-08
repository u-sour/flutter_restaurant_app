// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDataModel _$NotificationDataModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return NotificationDataModel(
    id: json['_id'] as String,
    type: json['type'] as String,
    refId: json['refId'] as String?,
    date: DateModelConverter.convertDateTimeOptionalForModel(
        json['date'] as DateTime?),
    markAsRead: json['markAsRead'] as bool?,
    tableId: json['tableId'] as String?,
    refNo: json['refNo'] as String?,
    table: json['table'] == null
        ? null
        : NotificationTableModel.fromJson(
            json['table'] as Map<String, dynamic>),
    department: json['department'] == null
        ? null
        : DepartmentModel.fromJson(json['department'] as Map<String, dynamic>),
    itemName: json['itemName'] as String?,
    qty: json['qty'] as num?,
    status: json['status'] as String?,
    tableName: json['tableName'] as String?,
    floorName: json['floorName'] as String?,
    category: json['category'] as String?,
    group: json['group'] as String?,
    showCategory: json['showCategory'] as bool?,
    extraItemDoc: (json['extraItemDoc'] as List<dynamic>?)
        ?.map((e) =>
            NotificationExtraItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NotificationDataModelToJson(
        NotificationDataModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'refId': instance.refId,
      'date': DateModelConverter.convertDateTimeOptionalForModel(instance.date),
      'markAsRead': instance.markAsRead,
      'tableId': instance.tableId,
      'refNo': instance.refNo,
      'table': instance.table?.toJson(),
      'department': instance.department?.toJson(),
      'itemName': instance.itemName,
      'qty': instance.qty,
      'status': instance.status,
      'tableName': instance.tableName,
      'floorName': instance.floorName,
      'category': instance.category,
      'group': instance.group,
      'showCategory': instance.showCategory,
      'extraItemDoc': instance.extraItemDoc?.map((e) => e.toJson()).toList(),
    };
