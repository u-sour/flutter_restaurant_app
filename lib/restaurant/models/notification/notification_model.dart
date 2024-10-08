import 'package:json_annotation/json_annotation.dart';
import 'notification_data_model.dart';
part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  final List<NotificationDataModel> data;
  final int totalCount;

  const NotificationModel({
    required this.data,
    required this.totalCount,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
