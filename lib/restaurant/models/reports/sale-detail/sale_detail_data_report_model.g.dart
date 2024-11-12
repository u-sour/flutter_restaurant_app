// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail_data_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetailDataReportModel _$SaleDetailDataReportModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id'],
  );
  return SaleDetailDataReportModel(
    id: json['_id'],
    date: DateModelConverter.convertDateTimeForModel(json['date'] as DateTime),
    employeeName: json['employeeName'] as String,
    itemName: json['itemName'] as String,
    qty: json['qty'] as num,
    price: json['price'] as num,
    amount: json['amount'] as num,
    discountAmount: json['discountAmount'] as num,
    details: (json['details'] as List<dynamic>)
        .map((e) =>
            SaleDetailDataDetailReportModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    groupLabel: json['groupLabel'] as String,
  );
}

Map<String, dynamic> _$SaleDetailDataReportModelToJson(
    SaleDetailDataReportModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['date'] = DateModelConverter.convertDateTimeForModel(instance.date);
  val['employeeName'] = instance.employeeName;
  val['itemName'] = instance.itemName;
  val['qty'] = instance.qty;
  val['price'] = instance.price;
  val['amount'] = instance.amount;
  val['discountAmount'] = instance.discountAmount;
  val['details'] = instance.details.map((e) => e.toJson()).toList();
  val['groupLabel'] = instance.groupLabel;
  return val;
}
