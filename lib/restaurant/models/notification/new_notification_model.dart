import 'package:json_annotation/json_annotation.dart';
import 'notification_data_model.dart';
part 'new_notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NewNotificationModel {
  final int newCount;
  final int unreadCount;
  final NotificationDataModel? lastestDoc;

  const NewNotificationModel(
      {required this.newCount, required this.unreadCount, this.lastestDoc});

  factory NewNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NewNotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewNotificationModelToJson(this);
}
