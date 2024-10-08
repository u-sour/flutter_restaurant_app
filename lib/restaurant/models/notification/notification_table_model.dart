import 'package:json_annotation/json_annotation.dart';
part 'notification_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationTableModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String floorId;
  final String name;
  final int numOfGuest;
  final String branchId;

  const NotificationTableModel({
    required this.id,
    required this.floorId,
    required this.name,
    required this.numOfGuest,
    required this.branchId,
  });

  factory NotificationTableModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationTableModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationTableModelToJson(this);
}
