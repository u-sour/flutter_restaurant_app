import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import '../department/department_model.dart';
import 'notification_extra_item_model.dart';
import 'notification_table_model.dart';
part 'notification_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationDataModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String type;
  final String? refId;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeOptionalForModel,
      toJson: DateModelConverter.convertDateTimeOptionalForModel)
  final DateTime? date;
  final bool? markAsRead;
  final String? tableId;
  final String? refNo;
  final NotificationTableModel? table;
  final DepartmentModel? department;
  // Chef Monitor
  final String? itemName;
  final num? qty;
  final String? status;
  final String? tableName;
  final String? floorName;
  final String? category;
  final String? group;
  final bool? showCategory;
  final List<NotificationExtraItemModel>? extraItemDoc;

  const NotificationDataModel({
    required this.id,
    required this.type,
    this.refId,
    this.date,
    this.markAsRead,
    this.tableId,
    this.refNo,
    this.table,
    this.department,
    // Chef Monitor
    this.itemName,
    this.qty,
    this.status,
    this.tableName,
    this.floorName,
    this.category,
    this.group,
    this.showCategory,
    this.extraItemDoc,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDataModelToJson(this);
}
