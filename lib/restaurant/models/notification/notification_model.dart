import 'package:json_annotation/json_annotation.dart';
import 'notification_data_model.dart';
part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  final List<NotificationDataModel> data;
  final String type;

  const NotificationModel({
    required this.data,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
